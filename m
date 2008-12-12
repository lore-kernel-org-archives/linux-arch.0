From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 20:47:30 +0100
Message-ID: <200812122047.31405.arnd@arndb.de>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:64779 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbYLLTs5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Dec 2008 14:48:57 -0500
In-Reply-To: <20081212152929.GM26095@parisc-linux.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 12 December 2008, Matthew Wilcox wrote:
> Things will go much better if we can prototype these as:
>=20
> asmlinkage ssize_t sys_preadv(unsigned int fd, const struct iovec __u=
ser *vec,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0loff_t pos, unsigned long vlen);
> asmlinkage ssize_t sys_pwritev(unsigned int fd, const struct iovec __=
user *vec,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0loff_t pos, unsigned long vlen);

I would vote for doing it the same way as sys_llseek, which avoids
this issue entirely by passing the upper half of pos sepearately:


asmlinkage ssize_t sys_preadv(unsigned long fd,
                               const struct iovec __user *vec,
                               unsigned long vlen,
			       unsigned long pos_high, unsigned long pos_low);
asmlinkage ssize_t sys_pwritev(unsigned long fd,
                               const struct iovec __user *vec,
                               unsigned long vlen,
			       unsigned long pos_high, unsigned long pos_low);

This is the only way I can see that lets us use a shared=20
compat_sys_preadv/pwritev across all 64 bit architectures.

The libc can then add a trivial wrapper around the syscalls
to get the regular calling conventions.

Aside from that, have you considered doing something even more flexible=
,
like this?

struct piovec {
	void __user *iov_base;
	__kernel_size_t	iov_len;
	__kernel_loff_t pos;
};

asmlinkage ssize_t sys_pwritev(unsigned long fd,
                               const struct piovec __user *vec,
                               unsigned long vlen);

	Arnd <><
