From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 6/6] Documentation: update arch list in the 'memtest' entry
Date: Mon,  9 Mar 2015 10:27:10 +0000
Message-ID: <1425896830-19705-7-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org, baruch@tkos.co.il, rdunlap@infradead.org
List-Id: linux-arch.vger.kernel.org

Since arm64/arm support memtest command line option update the "memtest"
entry.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-par=
ameters.txt
index bfcb1a6..ea11c98 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1988,7 +1988,7 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted.
 =09=09=09seconds.  Use this parameter to check at some
 =09=09=09other rate.  0 disables periodic checking.
=20
-=09memtest=3D=09[KNL,X86] Enable memtest
+=09memtest=3D=09[KNL,X86,ARM] Enable memtest
 =09=09=09Format: <integer>
 =09=09=09default : 0 <disable>
 =09=09=09Specifies the number of memtest passes to be
--=20
1.7.9.5


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
