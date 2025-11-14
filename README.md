# AH DevOps Pipeline (tests/docker/deploy)

Välkommen till mitt DevOps-projekt! Den här pipelinen automatiserar testning, byggande av Docker-image och deployment till Azure med hjälp av GitHub Actions och Terraform.

---

## Översikt av pipelinen

Pipelinen körs automatiskt vid push till `main`-grenen och kan även startas manuellt via GitHub Actions-fliken. Den består av tre steg:

1. **Test**  
   - Kör dina Python-tester med pytest.  
   - Om testerna misslyckas och du valt att skapa en artifact (`create_artefakt` = `true`), laddas testloggen upp som artifact.  
   - Om testerna misslyckas stoppas pipelinen här.

2. **Build and Push**  
   - Bygger en Docker-image baserat på din `Dockerfile`.  
   - Pushar imagen till ditt Docker Hub-repo med taggarna `latest` och ditt GitHub-run-nummer.  
   - Körs bara om testerna gick igenom.

3. **Terraform Deploy**  
   - Hanterar din Azure-infrastruktur med Terraform.  
   - Initierar, validerar, planerar och applicerar Terraform-konfigurationen i `./terraform`.  
   - Körs bara om Docker-bygget lyckades.

---

## Vad du behöver göra för att komma igång

### 1. Anpassa GitHub Secrets

För att pipelinen ska fungera behöver du lägga till följande secrets i ditt GitHub-repo:

- `DOCKER_USERNAME` – ditt Docker Hub-användarnamn.  
- `DOCKER_PASSWORD` – ditt Docker Hub-lösenord eller access token.  
- `AZURE_CREDENTIALS` – dina Azure Service Principal-uppgifter i JSON-format (för autentisering mot Azure).  
- `AZURE_SUBSCRIPTION_ID` – ditt Azure Subscription ID.

### 2. Anpassa Docker Hub-repot i pipelinen

I pipelinen (`build-and-push`-jobbet) finns en miljövariabel `REPO` som pekar på Docker Hub-repot där imagen pushas:

```yaml
env:
  REPO: alejandrohiroshima/alejandro
  ```

Byt ut värdet mot ditt eget Docker Hub-repo, t.ex.:

```yaml
env:
  REPO: ditt-användarnamn/ditt-repo
  ```

### 3. Anpassa Terraform-konfigurationen

I mappen ./terraform finns din Terraform-kod som skapar resurser i Azure.

- Kontrollera och ändra variabler som owner, resource_group_name eller andra som finns i variables.tf eller direkt i konfigurationsfilerna så att de passar din miljö och namngivningsstandard.
- Se till att resource_group_name inte krockar med befintliga resurser i din Azure-prenumeration, eller importera befintliga resurser i Terraform-state om du vill återanvända dem.

### 4. Kör pipelinen

- Vid push till main körs pipelinen automatiskt.
- Du kan också starta den manuellt via GitHub Actions-fliken och välja om du vill skapa artifact vid testfel (create_artefakt).


#### MVH

##### Alexander Hrachovina