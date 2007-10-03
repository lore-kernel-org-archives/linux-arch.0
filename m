Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:38176 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbXJCMMO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Oct 2007 08:12:14 -0400
Date: Wed, 3 Oct 2007 13:12:11 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [COMPAT] Add compat_merge64 helper
Message-ID: <20071003121211.GA14628@linux-mips.org>
References: <1191018832-18069-1-git-send-email-kyle@mcmartin.ca> <20070929094852.GA7715@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070929094852.GA7715@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Sep 29, 2007 at 11:48:52AM +0200, Heiko Carstens wrote:

> > +static inline u64 compat_merge64(u32 left, u32 right)
> > +{
> > +#if defined(__BIG_ENDIAN)
> > +	return ((u64)left << 32) | right;
> > +#else /* defined (__LITTLE_ENDIAN) */
> 
> Could you change that to an #elif please and #error out if none is defined?
> Should safe us from subtle bugs caused by missing includes.

This funny macro gets away without any extra headers or #ifdef messiness:

#define merge_64(r1,r2)							\
({									\
	union {								\
		int __words[2];						\
		long long	__dword;				\
	} __u = {							\
		.__words = { (r1), (r2) }				\
	};								\
									\
	__u.__dword;							\
})

Thanks to gcc doing bogus sign and zero extensions it compiles into
slightly larger code for MIPS but that may not be an issue on other
architectures.

   Ralf
