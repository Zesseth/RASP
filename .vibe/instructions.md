# AI Memory - Vibe Käynnistysohjeet

**TÄMÄ TIEDOSTO OHJAA KAIKKIA VIBE-KÄYNNISTYKSIÄ OMAT-PROJEKTEISSA**

## 🚨 KRIITTINEN: AI-MEMORY REPOSITORIO

**KAIKKI MUISTINPANOT, DOKUMENTAATIO JA OPPIMASI ASIAT TÄYTYY TALLENTAA TÄHÄN REPOSITORIOON:**
```
C:\Repos\Omat\ai-memory
```

**TÄMÄ REPOSITORIO PITÄÄ OLLA KAIKILLA KONEILLA, JOTKA KÄYTTÄVÄT VIBEA!**

---

## 🎯 VIBE-KÄYNNISTYKSEN OHJEET

### 1. Tarkista, että olet ai-memory repositoriossa

**ENNEN KUIN ALOITAT:**
```bash
# Tarkista nykyinen kansio
pwd

# Jos et ole ai-memory:ssä, siirry sinne
cd /c/Repos/Omat/ai-memory
```

### 2. Päivitä aina ennen työskentelyä

```bash
# Päivitä ai-memory repositorio
cd /c/Repos/Omat/ai-memory
git pull
```

**MISTRAL VIBE:** Jos käyttäjä yrittää tehdä jotain ilman, että on päivittänyt, **muistuta häntä ajamaan `git pull`!**

### 3. Jos työskentelet Omat-projektissa

```bash
# Siirry ai-memoryyn tallentamaan muistiinpanot
cd /c/Repos/Omat/ai-memory

# Tai luo muistiinpano suoraan oikeaan paikkaan
# Esimerkki: BeatForge-projektin muistiinpano
echo "# BeatForge - [aihe]" > /c/Repos/Omat/ai-memory/projects/BeatForge/YYYY-MM-DD-aihe.md
```

---

## 📁 MUISTIN TALLENTAMISEN SÄÄNNÖT

### ✅ TALLENNA AINA TÄHÄN:
```
C:\Repos\Omat\ai-memory/
```

### 📂 Rakenne:
```
ai-memory/
├── memory/          # Yleinen muisti (yleiset tiedot)
├── context/         # Projektien kontekstit
├── prompts/         # Valmiit prompt-pohjat
├── projects/        # **PROJEKTIKOHTAISET MUISTINPANOT**
│   ├── AlbumBrowser/
│   ├── BeatForge/
│   ├── ConvertFitToGarmin/
│   ├── MergePhotos/
│   ├── MountB2/
│   ├── ParadoxRoon/
│   ├── RASP/
│   ├── ReapOBS/
│   ├── RoonWishlist/
│   └── [uusi projekti]/
└── notes/           # Vapaamuotoiset muistiinpanot
```

### 🎯 Projektikohtainen tallennus:
- **AlbumBrowser** → `ai-memory/projects/AlbumBrowser/`
- **BeatForge** → `ai-memory/projects/BeatForge/`
- **ConvertFitToGarmin** → `ai-memory/projects/ConvertFitToGarmin/`
- **MergePhotos** → `ai-memory/projects/MergePhotos/`
- **MountB2** → `ai-memory/projects/MountB2/`
- **ParadoxRoon** → `ai-memory/projects/ParadoxRoon/`
- **RASP** → `ai-memory/projects/RASP/`
- **ReapOBS** → `ai-memory/projects/ReapOBS/`
- **RoonWishlist** → `ai-memory/projects/RoonWishlist/`

---

## 🔄 GIT-SYNKRONOINTI OHJEET

### Päivitä aina ennen työskentelyä:
```bash
cd /c/Repos/Omat/ai-memory
git pull
```

### Tallenna ja synkronoi muutokset:
```bash
cd /c/Repos/Omat/ai-memory

# Lisää kaikki muutokset
git add .

# Tee commit selkeällä viestillä
git commit -m "[Projekti]: [Kuvaus muutoksesta]"

# Pushaa GitHubiin
git push
```

---

## 🤖 MISTRAL VIBE OHJEET

### Jos käyttäjä:
1. **Yrittää tallentaa muistiinpanon väärään paikkaan** → Ohjaa `ai-memory` repositorioon
2. **Onee apua muistiin tallentamisesta** → Näytä tämä tiedosto
3. **Käynnistää Viben Omat-projektissa** → Muistuta talleta muistiinpanot `ai-memoryyn`
4. **Yrittää tehdä jotain ilman git pullia** → **Muistuta aina ajamaan `git pull` ennen työskentelyä!**

### Automaattiset muistutukset:
```
Vibe, muistuta käyttäjää aina:
- "Muista tallentaa kaikki muistiinpanot ai-memory repositorioon!"
- "Aja `cd /c/Repos/Omat/ai-memory && git pull` ennen työskentelyä!"
```

---

## 🚨 TURVALLISUUS

### ❌ ÄLÄ KOSKAAN TALLENNA:
- API-avaimia
- Salasanoja
- Henkilötietoja
- Luottokorttien tietoja
- Yksityisiä viestejä

### ✅ TALLENNA:
- Koodiesimerkkejä
- Dokumentaatiota
- Oppimiasi asioita
- Ongelmanratkaisuja
- Ideoita ja suunnitelmia

---

## 🎯 Pikanavigation

```bash
# Siirry ai-memoryyn
cd /c/Repos/Omat/ai-memory

# Päivitä
git pull

# Luo uusi muistiinpano
echo "# [Projekti] - [Aihe]" > projects/[Projekti]/YYYY-MM-DD-aihe.md

# Tallenna muutokset
git add .
git commit -m "[viesti]"
git push
```

---

**TÄRKEÄ:** Tämä tiedosto kuuluu `.vibe/` kansioon ja ohjaa kaikkia Vibe-käynnistyksiä Omat-projekteissa!
