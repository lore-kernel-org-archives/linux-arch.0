Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtp.tele.dk ([193.162.159.95]:24073 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751208AbWCKQLQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Mar 2006 11:11:16 -0500
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id E7FD91EC32B
	for <linux-arch@vger.kernel.org>; Sat, 11 Mar 2006 17:11:12 +0100 (CET)
Date: Sat, 11 Mar 2006 17:11:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC PATCH] get rid of duplicate exports from string.h
Message-ID: <20060311161106.GA19455@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
List-ID: <linux-arch.vger.kernel.org>

Following patch implements my suggestion how to get rid of the duplicate
exported symbols for the functions defined in lib/string.c and where
we often have arch optimised versions.

In lib/string.c export all symbols that are not defines.
And remove export from the arch ksyms file.

As an example I've done it for sparc64 but the same applies
for most architectures.

The latest version of kbuild - present in -mm - warns about duplicate
exported symbols. With this approch the primary offenders will be
removed.

Sample output:
WARNING: vmlinux: 'strcpy' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncpy' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strncat' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strcmp' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strrchr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strnlen' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strpbrk' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'strstr' exported twice. Previous export was in vmlinux
WARNING: vmlinux: 'memchr' exported twice. Previous export was in vmlinux


I did not find a better way than:
#if !defined(strcpy)
	EXPORT_SYMBOL(strcpy);
#endif
We need to check if the symbol is defined because we cannot
export a defined version of say memset as done by sparc64.


But if there is a better way to use the preprocessor I'm all ears.

Comments welcome.

	Sam


diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 3c06bfb..f2b174b 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -277,19 +277,8 @@ EXPORT_SYMBOL(__prom_getchild);
 EXPORT_SYMBOL(__prom_getsibling);
 
 /* sparc library symbols */
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strnlen);
 EXPORT_SYMBOL(__strlen_user);
 EXPORT_SYMBOL(__strnlen_user);
-EXPORT_SYMBOL(strcpy);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strncat);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strchr);
-EXPORT_SYMBOL(strrchr);
-EXPORT_SYMBOL(strpbrk);
-EXPORT_SYMBOL(strstr);
 
 #ifdef CONFIG_SOLARIS_EMUL_MODULE
 EXPORT_SYMBOL(linux_sparc_syscall);
@@ -323,7 +312,6 @@ EXPORT_SYMBOL(__memscan_zero);
 EXPORT_SYMBOL(__memscan_generic);
 EXPORT_SYMBOL(__memcmp);
 EXPORT_SYMBOL(__memset);
-EXPORT_SYMBOL(memchr);
 
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
@@ -354,11 +342,7 @@ EXPORT_SYMBOL(pfn_to_page);
 EXPORT_SYMBOL(__ret_efault);
 
 /* No version information on these, as gcc produces such symbols. */
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(strncmp);
 
 /* Delay routines. */
 EXPORT_SYMBOL(__udelay);
diff --git a/lib/string.c b/lib/string.c
index 037a48a..4af191e 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -57,7 +57,9 @@ int strnicmp(const char *s1, const char 
 	}
 	return (int)c1 - (int)c2;
 }
-EXPORT_SYMBOL(strnicmp);
+#endif
+#if !defined(strnicmp)
+	EXPORT_SYMBOL(strnicmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRCPY
@@ -75,7 +77,9 @@ char *strcpy(char *dest, const char *src
 		/* nothing */;
 	return tmp;
 }
-EXPORT_SYMBOL(strcpy);
+#endif
+#if !defined(strcpy)
+	EXPORT_SYMBOL(strcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCPY
@@ -104,7 +108,9 @@ char *strncpy(char *dest, const char *sr
 	}
 	return dest;
 }
-EXPORT_SYMBOL(strncpy);
+#endif
+#if !defined(strncpy)
+	EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCPY
@@ -130,7 +136,9 @@ size_t strlcpy(char *dest, const char *s
 	}
 	return ret;
 }
-EXPORT_SYMBOL(strlcpy);
+#endif
+#if !defined(strlcpy)
+	EXPORT_SYMBOL(strlcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRCAT
@@ -150,7 +158,9 @@ char *strcat(char *dest, const char *src
 		;
 	return tmp;
 }
-EXPORT_SYMBOL(strcat);
+#endif
+#if !defined(strcat)
+	EXPORT_SYMBOL(strcat);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCAT
@@ -179,7 +189,9 @@ char *strncat(char *dest, const char *sr
 	}
 	return tmp;
 }
-EXPORT_SYMBOL(strncat);
+#endif
+#if !defined(strncat)
+	EXPORT_SYMBOL(strncat);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCAT
@@ -206,7 +218,9 @@ size_t strlcat(char *dest, const char *s
 	dest[len] = 0;
 	return res;
 }
-EXPORT_SYMBOL(strlcat);
+#endif
+#if !defined(strlcat)
+	EXPORT_SYMBOL(strlcat);
 #endif
 
 #ifndef __HAVE_ARCH_STRCMP
@@ -226,7 +240,9 @@ int strcmp(const char *cs, const char *c
 	}
 	return __res;
 }
-EXPORT_SYMBOL(strcmp);
+#endif
+#if !defined(strcmp)
+	EXPORT_SYMBOL(strcmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCMP
@@ -247,7 +263,9 @@ int strncmp(const char *cs, const char *
 	}
 	return __res;
 }
-EXPORT_SYMBOL(strncmp);
+#endif
+#if !defined(strncmp)
+	EXPORT_SYMBOL(strncmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRCHR
@@ -263,7 +281,9 @@ char *strchr(const char *s, int c)
 			return NULL;
 	return (char *)s;
 }
-EXPORT_SYMBOL(strchr);
+#endif
+#if !defined(strchr)
+	EXPORT_SYMBOL(strchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRRCHR
@@ -281,7 +301,9 @@ char *strrchr(const char *s, int c)
        } while (--p >= s);
        return NULL;
 }
-EXPORT_SYMBOL(strrchr);
+#endif
+#if !defined(strrchr)
+	EXPORT_SYMBOL(strrchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCHR
@@ -298,7 +320,9 @@ char *strnchr(const char *s, size_t coun
 			return (char *)s;
 	return NULL;
 }
-EXPORT_SYMBOL(strnchr);
+#endif
+#if !defined(strnchr)
+	EXPORT_SYMBOL(strnchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRLEN
@@ -314,7 +338,9 @@ size_t strlen(const char *s)
 		/* nothing */;
 	return sc - s;
 }
-EXPORT_SYMBOL(strlen);
+#endif
+#if !defined(strlen)
+	EXPORT_SYMBOL(strlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRNLEN
@@ -331,7 +357,9 @@ size_t strnlen(const char *s, size_t cou
 		/* nothing */;
 	return sc - s;
 }
-EXPORT_SYMBOL(strnlen);
+#endif
+#if !defined(strnlen)
+	EXPORT_SYMBOL(strnlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRSPN
@@ -358,8 +386,9 @@ size_t strspn(const char *s, const char 
 	}
 	return count;
 }
-
-EXPORT_SYMBOL(strspn);
+#endif
+#if !defined(strspn)
+	EXPORT_SYMBOL(strspn);
 #endif
 
 /**
@@ -403,7 +432,9 @@ char *strpbrk(const char *cs, const char
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(strpbrk);
+#endif
+#if !defined(strpbrk)
+	EXPORT_SYMBOL(strpbrk);
 #endif
 
 #ifndef __HAVE_ARCH_STRSEP
@@ -432,7 +463,9 @@ char *strsep(char **s, const char *ct)
 	*s = end;
 	return sbegin;
 }
-EXPORT_SYMBOL(strsep);
+#endif
+#if !defined(strsep)
+	EXPORT_SYMBOL(strsep);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSET
@@ -452,7 +485,9 @@ void *memset(void *s, int c, size_t coun
 		*xs++ = c;
 	return s;
 }
-EXPORT_SYMBOL(memset);
+#endif
+#if !defined(memset)
+	EXPORT_SYMBOL(memset);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCPY
@@ -474,7 +509,9 @@ void *memcpy(void *dest, const void *src
 		*tmp++ = *s++;
 	return dest;
 }
-EXPORT_SYMBOL(memcpy);
+#endif
+#if !defined(memcpy)
+	EXPORT_SYMBOL(memcpy);
 #endif
 
 #ifndef __HAVE_ARCH_MEMMOVE
@@ -506,7 +543,9 @@ void *memmove(void *dest, const void *sr
 	}
 	return dest;
 }
-EXPORT_SYMBOL(memmove);
+#endif
+#if !defined(memmove)
+	EXPORT_SYMBOL(memmove);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
@@ -527,7 +566,9 @@ int memcmp(const void *cs, const void *c
 			break;
 	return res;
 }
-EXPORT_SYMBOL(memcmp);
+#endif
+#if !defined(memcmp)
+	EXPORT_SYMBOL(memcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN
@@ -552,7 +593,9 @@ void *memscan(void *addr, int c, size_t 
 	}
   	return (void *)p;
 }
-EXPORT_SYMBOL(memscan);
+#endif
+#if !defined(memscan)
+	EXPORT_SYMBOL(memscan);
 #endif
 
 #ifndef __HAVE_ARCH_STRSTR
@@ -577,7 +620,9 @@ char *strstr(const char *s1, const char 
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(strstr);
+#endif
+#if !defined(strstr)
+	EXPORT_SYMBOL(strstr);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCHR
@@ -600,5 +645,7 @@ void *memchr(const void *s, int c, size_
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(memchr);
+#endif
+#if !defined(memchr)
+	EXPORT_SYMBOL(memchr);
 #endif
