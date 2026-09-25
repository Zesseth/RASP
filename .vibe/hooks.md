# AI Memory - Vibe Hooks (Käynnistysautomaatio)

**TÄMÄ TIEDOSTO MÄÄRITTELEE VIBE-KÄYNNISTYKSEN HOOKIT AI-MEMORYN OSALTA**

## 🎯 Käynnistyksen Automaattiset Toimenpiteet

### 1. Pre-start Hook (Ennen käynnistystä)

**Tarkoituksena**: Varmistaa, että ai-memory repositorio on päivitetty ennen Vibe-käynnistystä.

```bash
#!/bin/bash
# Tarkista, onko ai-memory repositorio olemassa
if [ -d "/c/Repos/Omat/ai-memory/.git" ]; then
    echo "Päivitetään ai-memory repositorio..."
    cd /c/Repos/Omat/ai-memory
    git pull
    echo "ai-memory päivitys valmis!"
fi
```

### 2. Post-start Hook (Käynnistyksen jälkeen)

**Tarkoituksena**: Muistuttaa käyttäjää ai-memory repositoriosta.

```bash
#!/bin/bash
echo ""
echo "🎯 MUISTUTUS: Kaikki muistiinpanot tulee tallentaa ai-memory repositorioon!"
echo "   Sijainti: C:\Repos\Omat\ai-memory"
echo "   Komento: cd /c/Repos/Omat/ai-memory && git pull"
echo ""
```

---

## 📋 Hookien Konfigurointi

### Vibe CLI Hookit

Vibe CLI tukee seuraavia hookkeja `.vibe/` kansiosta:
- `pre-start.sh` - Suoritetaan ennen Vibe-käynnistystä
- `post-start.sh` - Suoritetaan Vibe-käynnistyksen jälkeen

### Hookien Luoominen

1. **pre-start.sh**:
```bash
# Luo tiedosto
cat > /c/Repos/Omat/ai-memory/.vibe/pre-start.sh << 'EOF'
#!/bin/bash
if [ -d "/c/Repos/Omat/ai-memory/.git" ]; then
    echo "[AI-Memory] Päivitetään repositorio..."
    cd /c/Repos/Omat/ai-memory
    git pull 2>/dev/null
    echo "[AI-Memory] Repositorio päivitetty!"
fi
EOF

# Tee suoritettavaksi
chmod +x /c/Repos/Omat/ai-memory/.vibe/pre-start.sh
```

2. **post-start.sh**:
```bash
# Luo tiedosto
cat > /c/Repos/Omat/ai-memory/.vibe/post-start.sh << 'EOF'
#!/bin/bash
echo ""
echo "🎯 [AI-Memory] Kaikki muistiinpanot tulee tallentaa: C:\Repos\Omat\ai-memory"
echo "   Muista ajaa: git pull"
echo ""
EOF

# Tee suoritettavaksi
chmod +x /c/Repos/Omat/ai-memory/.vibe/post-start.sh
```

---

## 🔄 Manuaalinen Päivitys

Jos hookit eivät toimi, aja manuaalisesti:

```bash
# Päivitä ai-memory
cd /c/Repos/Omat/ai-memory
git pull

# Siirry takaisin työskentelykansioon
cd /c/Repos/Omat/[projekti]
```

---

## 📝 Ohjeet Vibe-käyttäjälle

### Jos käytät Vibe CLI:tä:

1. **Aseta hookit**: Kopioi yllä olevat skriptit `.vibe/` kansioon
2. **Tee ne suoritettaviksi**: `chmod +x .vibe/*.sh`
3. **Testaa**: Käynnistä Vibe uudestaan

### Jos hookit eivät toimi:
- Tarkista, että `.vibe/` kansio on olemassa
- Tarkista, että tiedostot ovat suoritettavia
- Tarkista, että olet oikeassa kansiossa

---

## 🎯 Tärkeät Muistutukset

1. **ai-memory repositorion pitää olla kaikilla koneilla**
2. **Päivitä aina ennen työskentelyä**: `git pull`
3. **Tallenna muutokset säännöllisesti**: `git add . && git commit && git push`
4. **Älä tallenna salaista dataa**

---

**Hookit auttavat pitämään muistin ajan tasalla automaattisesti!**
