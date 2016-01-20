From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v4 2/8] lib: add "on" and "off" to strtobool
Date: Tue, 19 Jan 2016 18:09:38 -0800
Message-ID: <1453255778.25071.26.camel@perches.com>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
	 <1453226922-16831-3-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0016.hostedemail.com ([216.40.44.16]:44295 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933337AbcATCJm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Jan 2016 21:09:42 -0500
In-Reply-To: <1453226922-16831-3-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Daniel Borkmann <daniel@iogearbox.net>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

On Tue, 2016-01-19 at 10:08 -0800, Kees Cook wrote:
> Several places in the kernel expect to use "on" and "off" for their
> boolean signifiers, so add them to strtobool.

Several places in the kernel use a char address like
fs/cifs/cifs_debug.c


	char c;
	...


	if (strtobool(&c, ...))

Using s[1] might cause problems for those uses.
> diff --git a/lib/string.c b/lib/string.c
[]
> @@ -635,12 +635,15 @@ EXPORT_SYMBOL(sysfs_streq);
> =A0 * @s: input string
> =A0 * @res: result
> =A0 *
> - * This routine returns 0 iff the first character is one of 'Yy1Nn0'=
=2E
> - * Otherwise it will return -EINVAL.=A0=A0Value pointed to by res is
> - * updated upon finding a match.
> + * This routine returns 0 iff the first character is one of 'Yy1Nn0'=
, or
> + * [oO][NnFf] for "on" and "off". Otherwise it will return -EINVAL.=A0=
=A0Value
> + * pointed to by res is updated upon finding a match.
> =A0 */
> =A0int strtobool(const char *s, bool *res)
> =A0{
> +	if (!s)
> +		return -EINVAL;
> +
> =A0	switch (s[0]) {
> =A0	case 'y':
> =A0	case 'Y':
> @@ -652,6 +655,21 @@ int strtobool(const char *s, bool *res)
> =A0	case '0':
> =A0		*res =3D false;
> =A0		break;
> +	case 'o':
> +	case 'O':
> +		switch (s[1]) {
> +		case 'n':
> +		case 'N':
> +			*res =3D true;
> +			break;
> +		case 'f':
> +		case 'F':

Perhaps
		switch (tolower(s[1])) {
is more readable

> +			*res =3D false;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;

or maybe /* fallthrough */

> =A0	default:
> =A0		return -EINVAL;
> =A0	}
