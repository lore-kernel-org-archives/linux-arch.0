From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 42/56] microblaze_v2: stats headers
Date: Mon, 5 May 2008 00:31:38 +0200
Message-ID: <200805050031.40054.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <64e6fc7378cd5c714fcceef7d4965c1fb3d1b288.1209897266.git.monstr@monstr.eu> <9cc0d54a98f25748dc3f16fc3250524d7cd00877.1209897266.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:53625 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYEDWcO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 18:32:14 -0400
In-Reply-To: <9cc0d54a98f25748dc3f16fc3250524d7cd00877.1209897266.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, Michal Simek <monstr@monstr.eu>

On Sunday 04 May 2008, monstr@seznam.cz wrote:
> +struct stat {
> +	unsigned int	st_dev;
> +	unsigned long	st_ino;
> +	unsigned int	st_mode;
> +	unsigned int	st_nlink;
> +	unsigned int	st_uid;
> +	unsigned int	st_gid;
> +	unsigned int	st_rdev;
> +	long		st_size;
> +	unsigned long	st_blksize;
> +	unsigned long	st_blocks;
> +	unsigned long	st_atime;
> +	unsigned long	__unused1;
> +	unsigned long	st_mtime;
> +	unsigned long	__unused2;
> +	unsigned long	st_ctime;
> +	unsigned long	__unused3;
> +	unsigned long	__unused4;
> +	unsigned long	__unused5;
> +};
> +
> +struct stat64 {
> +	unsigned long long	st_dev;
> +	unsigned long	__unused1;
> +
> +	unsigned long long	st_ino;
> +
> +	unsigned int	st_mode;
> +	unsigned int	st_nlink;
> +
> +	unsigned int	st_uid;
> +	unsigned int	st_gid;
> +
> +	unsigned long long	st_rdev;
> +	unsigned long	__unused3;
> +
> +	long long	st_size;
> +	unsigned long	st_blksize;
> +
> +	unsigned long	st_blocks; /* No. of 512-byte blocks allocated */
> +	unsigned long	__unused4; /* future possible st_blocks high bits */
> +
> +	unsigned long	st_atime;
> +	unsigned long	st_atime_nsec;
> +
> +	unsigned long	st_mtime;
> +	unsigned long	st_mtime_nsec;
> +
> +	unsigned long	st_ctime;
> +	unsigned long	st_ctime_nsec;
> +
> +	unsigned long	__unused8;
> +};

There should only be a 'struct stat', not stat64, and it would be nice
to have that in asm-generic/stat.h.

I think it should be defined as

struct stat {
	unsigned long long	st_dev;

	unsigned long long	st_ino;

	unsigned int		st_mode;
	unsigned int		st_nlink;

	unsigned int		st_uid;
	unsigned int		st_gid;

	unsigned long long	st_rdev;

	long long		st_size;

	unsigned int		st_blksize;
	unsigned int		__unused1;

	unsigned long long	st_blocks; /* No. of 512-byte blocks allocated */

	unsigned int		st_atime;
	unsigned int		st_atime_nsec;

	unsigned int		st_mtime;
	unsigned int		st_mtime_nsec;

	unsigned int		st_ctime;
	unsigned int		st_ctime_nsec;

	unsigned int		__unused2;
	unsigned int		__unused3;
};

This way, you don't have any unnecessary padding, and the structure
is compatible in 32 and 64 bit architectures.

	Arnd <><
