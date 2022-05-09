<?php

/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en « wp-config.php » et remplir les
 * valeurs.
 *
 * Ce fichier contient les réglages de configuration suivants :
 *
 * Réglages MySQL
 * Préfixe de table
 * Clés secrètes
 * Langue utilisée
 * ABSPATH
 *
 * @link https://fr.wordpress.org/support/article/editing-wp-config-php/.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'wordpress_db');


/** Utilisateur de la base de données MySQL. */
define('DB_USER', '');


/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', '');


/** Adresse de l’hébergement MySQL. */
define('DB_HOST', 'localhost');


/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8mb4');


/**
 * Type de collation de la base de données.
 * N’y touchez que si vous savez ce que vous faites.
 */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clés secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '/%8m_k4t7m+>2;AVO`2hV.h|-E@V[{YBbT=h.J}%Bd?=2wrGWghx*|8|IY/2 ^n7');
define('SECURE_AUTH_KEY',  'sws8?ve^.aht~&Tfex!^:ntB!sE~Al{3--]=ltw)Y,<)WEIm0hgT/NMV/ZSYMQ: ');
define('LOGGED_IN_KEY',    'a+Zd<*o)0!5KXlbRP4ttWe+ZolB[U_xY}}l`<`2|mwR{Tejf&>bI||!#e4Hp~y-t');
define('NONCE_KEY',        'sSI54<VgXX1(;8[DKdfO1;|+|zI-=p_|E-3|S|o5QM m5O?j1U]bgB1|#?2KS2ho');
define('AUTH_SALT',        ')|BRAF{l8GeizC f*B>lL;@bFJzm1U7-JcZbjAGw0-d857T|L%@l)?Mu|%ag[9U=');
define('SECURE_AUTH_SALT', 'b&ioeaDF0~(WI I4gn[p#)|1Gd+i/C,cBQ#T1-4p352RhM<*!Wzcy ? PNoR$ 59');
define('LOGGED_IN_SALT',   '2|7UL],^:rGAxP|k/jKwBg[I0Q0+clNQl]}YkZ<Z1|r9G%4y`/MlASqN6jo=6_|9');
define('NONCE_SALT',       'W((,}<FJ<Wp~u]-LsJ&dh= X.D0,${`<J |K-A)MiT+}4h:`>;dQ^->/2PoqkWzZ');

/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wpdb22_';


/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortement recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://fr.wordpress.org/support/article/debugging-in-wordpress/
 */
define('WP_DEBUG', false);
// define('FORCE_SSL_ADMIN', true);
// define( 'WP_HOME', 'https://' );
// define( 'WP_SITEURL', 'https://' );

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if (!defined('ABSPATH'))
    define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');
