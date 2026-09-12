Received: from mail.cock.li (mail.cock.li [37.120.193.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3B314A73;
	Sat, 12 Sep 2026 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250352; cv=none; b=OKd+nr66xVYnTIRMbeo6hk3Y2rhS4N2ka7lR63zs4n6MeuJcaROX+tbBOy7ZICtIwTYe6fVOvHCaoZfd2FjFAgJ8F34YlHjJH2TNPexZjuwdyPPgZ+99XSK3ISUqlumANh4YQS/tnMqtI1za/T6ZLK6Id3+KIO1VYnkJfnUp+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250352; c=relaxed/simple;
	bh=VW8F22p449+zFSEUhbHDye81XIvDVNO4ILh6KfBONlg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=L6UBLrkrONk0Pmfk3pGFUSIIYFJYDWj/6E0YNK0LNNLk9bDsrfoBHaYyfvirtZbTG9kdWX4FobGYA8baZ4uSe9bl3qDBQb7Ola743mCA4bETbL21s40w0jDyTqrUkfbl0h/6RTJGCrEZRHoHKlhxEUaMQm8f/k25ZSM40Xs6ffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=memeware.net; spf=pass smtp.mailfrom=memeware.net; dkim=pass (2048-bit key) header.d=memeware.net header.i=@memeware.net header.b=jSVkUtBg; arc=none smtp.client-ip=37.120.193.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=memeware.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memeware.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=memeware.net header.i=@memeware.net header.b="jSVkUtBg"
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=memeware.net; s=mail;
	t=1789250337; bh=VW8F22p449+zFSEUhbHDye81XIvDVNO4ILh6KfBONlg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jSVkUtBguRH87GGSf6sQNCcStV1EWnJaPEDTidC7r4Y1HOSze+1pGDZ1zAL7qYsAE
	 BP2X/+PahERzwMZ+HVrs5GBM+UJzD8fBnPiGTUhVDTt4j6PrkDYO1r7onYWPl+yalo
	 Xg+7alpWCY3K4SoimUeFARkd++UAjea6PsSFNMKqltuscCk8HC0cP4+/uJszzLKvWl
	 E0zsywTY+U8MRV6e6HWO5a0syQDkZxrVP7mKSq3Z1ejuvGrq6utxp0prQURxYnIVxi
	 h2w78Rw7rOlSmmUXlTQoGDwgdYZCX/HQ29peBJbCtKgXW/j80qUHhFuxqL59JYoRpO
	 s0MS7EGAM8MGw==
Date: Sat, 12 Sep 2026 21:58:26 +0000
Message-Id: <DLDOAQWX9IIH.E1ZNJ3O80VQ@memeware.net>
Cc: "linux-man" <linux-man@vger.kernel.org>, "Linux-Arch"
 <linux-arch@vger.kernel.org>
Subject: Re: outb(2): terminology correction
From: "astian" <astian@memeware.net>
To: "Arnd Bergmann" <arnd@arndb.de>, "Alejandro Colomar" <alx@kernel.org>,
 "Andreas Jaeger" <aj@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
References: <DL30FONT5B6G.1ETPJ04T023RU@memeware.net>
 <aqPmNKbqjBILjoqw@devuan>
 <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>
In-Reply-To: <b6258140-1ece-4113-bcb4-025302ef59cc@app.fastmail.com>

On 11 Sep 2026 13:43 +0200, Alejandro Colomar wrote:
>> Date: 2026-09-11 13:36:29+0200
>> From: Alejandro Colomar <alx@kernel.org>
>>
>> [CC +=3D GENERIC INCLUDE/ASM HEADER FILES maintainers]
>>=20
>> Hi astian, Arnd,
>>=20
>> > Date: 2026-08-31 09:09:46+0000
>> > From: astian <astian@memeware.net>
>> >
>> > outb(2) says:
>> >
>> >   You must compile with -O or -O2 or similar.  The functions are defin=
ed
>> >   as inline macros, and will not be substituted in without optimizatio=
n
>> >   enabled, causing unresolved references at link time.
>> >
>> > "inline macros [...] not substituted in without optimization" doesn't
>> > make any sense.  C pre-processor macros cannot be inline or not inline=
.
>> > Indeed these are inline *functions* (at least in this system) with
>> > embedded assembly apparently referencing parameters (which, I surmise,
>> > is why the functions need to be inlined by the compiler or the assembl=
y
>> > will not work).
>> >
>> > From /usr/include/x86_64-linux-gnu/sys/io.h (glibc 2.43):
>> >
>> >   [...]
>> >   #if defined __GNUC__ && __GNUC__ >=3D 2
>> >
>> >   static __inline unsigned char
>> >   inb (unsigned short int __port)
>> >   {
>> >     unsigned char _v;
>> >
>> >     __asm__ __volatile__ ("inb %w1,%0":"=3Da" (_v):"Nd" (__port));
>> >     return _v;
>> >   }
>> >
>> >   [...]
>> >
>> >   static __inline void
>> >   outb (unsigned char __value, unsigned short int __port)
>> >   {
>> >     __asm__ __volatile__ ("outb %b0,%w1": :"a" (__value), "Nd" (__port=
));
>> >   }
>> >
>> >   [...]
>> >
>> > So I would say just s/inline macros/inline functions/g.
>>
>> Yes, 'inline functions' seems more appropriate than 'inline macros' (all
>> macros are inlined, due to how the preprocessor works, so they'd be just
>> macros, and as you showed, these are not even macros --except maybe in
>> some architectures--).
>>
>> However, I doubt the entire paragraph.  I don't know why inline
>> functions would produce unresolved references at link time _even if they
>> were not substituted_.  The point of inline functions is that they are
>> sometimes inlined, and sometimes not, and the compiler does the right
>> thing in both cases.
>>
>> This seems like paranoia from decades ago, when inline functions were
>> less known (and maybe compilers were more buggy than they are now).
>>
>> Arnd, should we remove the paragraph entirely?  Or is there any obscure
>> reason why optimizations are required?
>
> Or maybe those assembly instructions are what causes the linker issues?
> If so, we should probably say something about that.

I had a closer look and I now think that's not the case.  These
instructions work fine even if the function is not inlined.  See more
below.

On 11 Sep 2026 14:20 +0200, Arnd Bergmann wrote:
> My best guess is that this described a bug in glibc that was fixed in
> https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3D994cc0ea88ce=
7a33d532b735c0723705742b1a7e
>
> commit 994cc0ea88ce7a33d532b735c0723705742b1a7e
> Author: Andreas Jaeger <aj@suse.de>
> Date:   Wed Aug 23 16:57:31 2000 +0000
>
>     (_EXTERN_INLINE): Remove. Use static __inline instead of _EXTERN_INLI=
NE.
>
> --- a/sysdeps/unix/sysv/linux/i386/sys/io.h
> +++ b/sysdeps/unix/sysv/linux/i386/sys/io.h
> @@ -40,12 +40,7 @@ extern int iopl (int __level) __THROW;
> =20
>  #if defined __GNUC__ && __GNUC__ >=3D 2
> =20
> -# ifndef _EXTERN_INLINE
> -#  define _EXTERN_INLINE extern __inline
> -# endif
> -
> -
> -_EXTERN_INLINE unsigned char
> +static __inline unsigned char
>  inb (unsigned short int port)
>  {
>    unsigned char _v;
> ...
>
> Using 'extern __inline' without optimization in --std=3Dgnu89 would lead =
to
> the compiler using an 'extern' reference rather than emitting a static
> version,

This seems to be the original reason for the optimisation requirement.
The manual says [0]:

  GCC does not inline any functions when not optimizing unless you
  specify the =E2=80=98always_inline=E2=80=99 attribute for the function [.=
..]

  [...]

  If you specify both inline and extern in the function definition, then
  the definition is used only for inlining.  In no case is the function
  compiled on its own, not even if you refer to its address explicitly.
  Such an address becomes an external reference, as if you had only
  declared the function, and had not defined it.

  This combination of inline and extern has almost the effect of a
  macro. [...]

  0: https://gcc.gnu.org/onlinedocs/gcc/Inline.html

Thus, using "extern inline" but not enabling optimisations (and not
providing a separate definition in some other object) would have
produced a linker error.

> the 'static __inline' variant works as intended in both gnu
> and standard c99.

That "__inline" keyword (yes, it's a keyword, regardless of eponymous
macros) is odd.  Apparently an old non-standard import from MSVC.

Are standard/newer keywords (inline/__inline__) not used for reasons of
backward compatibility (with old compiler or C language versions)?
