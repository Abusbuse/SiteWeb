package javaPlanning;

public class Circuit {
    
    private String name, adresse;
    private int nbrMaxPlace;

    public Circuit(String name, String adresse, int nbrMaxPlace) {
        this.name = name;
        this.adresse = adresse;
        this.nbrMaxPlace = nbrMaxPlace;
    }

    public int getNbrMaxPlace() {
        return nbrMaxPlace;
    }

    public void setNbrMaxPlace(int nbrMaxPlace) {
        this.nbrMaxPlace = nbrMaxPlace;
    }

    public String getName() {
        return name;
    }

    public String getAdresse() {
        return adresse;
    }

    @Override
    public String toString() {
        return (name + ", " + adresse + ", " + nbrMaxPlace + " places");
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((name == null) ? 0 : name.hashCode());
        result = prime * result + ((adresse == null) ? 0 : adresse.hashCode());
        result = prime * result + nbrMaxPlace;
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Circuit other = (Circuit) obj;
        if (name == null) {
            if (other.name != null)
                return false;
        } else if (!name.equals(other.name))
            return false;
        if (adresse == null) {
            if (other.adresse != null)
                return false;
        } else if (!adresse.equals(other.adresse))
            return false;
        if (nbrMaxPlace != other.nbrMaxPlace)
            return false;
        return true;
    }
}