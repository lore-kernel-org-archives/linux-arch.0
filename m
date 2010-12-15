From: Tony Luck <tony.luck@intel.com>
Subject: Re: Big git diff speedup by avoiding x86 "fast string" memcmp
Date: Wed, 15 Dec 2010 15:09:26 -0800
Message-ID: <AANLkTim=Hd_xhk4egrTq96rk0eCQRWOxEjcfxM53HwXq@mail.gmail.com>
References: <20101209070938.GA3949@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f180.google.com ([209.85.214.180]:39405 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab0LOXJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Dec 2010 18:09:28 -0500
In-Reply-To: <20101209070938.GA3949@amd>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org

On Wed, Dec 8, 2010 at 11:09 PM, Nick Piggin <npiggin@kernel.dk> wrote:
> +static inline int dentry_memcmp(const unsigned char *cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const u=
nsigned char *ct, size_t count)
> +{
> + =A0 =A0 =A0 while (count) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D (*cs !=3D *ct);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ct++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count--;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}

Since you are proposing a routine that only compares file
names - I wonder whether it would be faster to start at the
end and work backwards? If the filenames are the same,
it makes no difference - you have to look at all the bytes.
But if they are different you might bail out earlier. There
are many applications that stick a common prefix onto
the start of filenames (just look in "/lib" !), but I think it is
less common to add a suffix (longer than "." single letter).

-Tony
