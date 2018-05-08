From: Joel Fernandes <joel.opensrc@gmail.com>
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
Date: Mon, 07 May 2018 20:23:09 -0700
Message-ID: <9AE4F1FC-2B6A-4EB4-8626-9936B8EB5CBB@gmail.com>
References: <20180507231506.4891-1-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de, arnd@arndb.de, cl@linux.com
Cc: keescook@chromium.org, luto@amacapital.net, longman@redhat.com, viro@zeniv.linux.org.uk, willy@infradead.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On May 7, 2018 4:15:06 PM PDT, "Luis R=2E Rodriguez" <mcgrof@kernel=2Eorg>=
 wrote:
>__read_mostly can easily be misused by folks, its not meant for
>just read-only data=2E There are performance reasons for using it, but
>we also don't provide any guidance about its use=2E Provide a bit more
>guidance over it use=2E
>
>Signed-off-by: Luis R=2E Rodriguez <mcgrof@kernel=2Eorg>
>---
> include/linux/cache=2Eh | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>Every now and then we get a patch suggesting to use __read_mostly for
>something new or old but with no justifications=2E Add a bit more
>verbiage to help guide its users=2E
>
>Is this sufficient documentation to at least ask for a reason in the
>commit
>log as to why its being used for new entries? Or should we be explicit
>and
>ask for such justifications in commit logs? Taken from prior
>discussions
>with Christoph Lameter [0] over its use=2E
>
>[0]
>https://lkml=2Ekernel=2Eorg/r/alpine=2EDEB=2E2=2E11=2E1504301343190=2E288=
79@gentwo=2Eorg
>
>diff --git a/include/linux/cache=2Eh b/include/linux/cache=2Eh
>index 750621e41d1c=2E=2E62bc5adc0ed5 100644
>--- a/include/linux/cache=2Eh
>+++ b/include/linux/cache=2Eh
>@@ -15,8 +15,14 @@
>=20
> /*
>* __read_mostly is used to keep rarely changing variables out of
>frequently
>- * updated cachelines=2E If an architecture doesn't support it, ignore
>the
>- * hint=2E
>+ * updated cachelines=2E Its use should be reserved for data that is
>used
>+ * frequently in hot paths=2E Performance traces can help decide when to
>use
>+ * this=2E You want __read_mostly data to be tightly packed, so that in
>the
>+ * best case multiple frequently read variables for a hot path will be
>next
>+ * to each other in order to reduce the number of cachelines needed to
>+ * execute a critial path=2E We should be mindful and selective if its

Nit: in its use=2E

- Joel


>use=2E
>+ *
>+ * If an architecture doesn't support it, ignore the hint=2E
>  */
> #ifndef __read_mostly
> #define __read_mostly

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
