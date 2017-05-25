From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH v5 4/6] linux/bug.h: correct "space required before that '-'"
Date: Thu, 25 May 2017 16:02:46 +0200
Message-ID: <xa1t4lw9hw55.fsf@mina86.com>
References: <20170525120316.24473-1-abbotti@mev.co.uk> <20170525120316.24473-5-abbotti@mev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170525120316.24473-5-abbotti@mev.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>, Ian Abbott <abbotti@mev.co.uk>, Jakub Kicinski <jakub.kicinski@netronome.com>, Johannes Berg <johannes.berg@intel.com>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 25 2017, Ian Abbott wrote:
> Correct these checkpatch.pl errors:
>
> |ERROR: space required before that '-' (ctx:OxO)
> |#37: FILE: include/linux/bug.h:37:
> |+#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
>
> |ERROR: space required before that '-' (ctx:OxO)
> |#38: FILE: include/linux/bug.h:38:
> |+#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
>
> I decided to wrap the bitfield expressions that begin with minus signs
> in parentheses rather than insert spaces before the minus signs.
>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

To be honest though, I would squash the fixes with the rename.

> ---
> v5: Actually, there was no v1 thru v4.  I called this v5 to match the
> series.
> ---
>  include/linux/bug.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bug.h b/include/linux/bug.h
> index 216a1b79653d..483207cb99fb 100644
> --- a/include/linux/bug.h
> +++ b/include/linux/bug.h
> @@ -36,8 +36,8 @@ struct pt_regs;
>   * e.g. in a structure initializer (or where-ever else comma expressions
>   * aren't permitted).
>   */
> -#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
> -#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))
> +#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
> +#define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:(-!!(e)); }))
>=20=20
>  /*
>   * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of =
the

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=83=
=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
