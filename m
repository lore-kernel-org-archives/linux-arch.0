From: Michal Simek <monstr@seznam.cz>
Subject: Re: [PATCH 58/60] microblaze_v4: sys_microblaze.c
Date: Thu, 26 Jun 2008 21:07:30 +0200
Message-ID: <4863E8F2.5080608@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-58-git-send-email-monstr@seznam.cz> <1214483429-32360-59-git-send-email-monstr@seznam.cz> <200806261748.30698.arnd@arndb.de>
Reply-To: monstr@seznam.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:38894 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755221AbYFZTGc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 15:06:32 -0400
In-Reply-To: <200806261748.30698.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>


>> +
>> +/*
>> + * sys_ipc() is the de-multiplexer for the SysV IPC calls..
>> + *
>> + * This is really horribly ugly.
>> + */
> 
> If it's so horribly ugly, don't do it this way ;-)

:-) this is not my part of code. I'll remove it with syscall changes.

>> +int
>> +sys_ipc(uint call, int first, int second, int third, void *ptr, long fifth)
>> +{
>> +	int version, ret;
>> +
>> +	version = call >> 16; /* hack for backward compatibility */
>> +	call &= 0xffff;
> 
> Backwards compatibility with what?

I don't know.
John: I suppose this is your comment.

>> +static inline unsigned long
>> +do_mmap2(unsigned long addr, size_t len,
>> +	unsigned long prot, unsigned long flags,
>> +	unsigned long fd, unsigned long pgoff)
>> +{
>> +	struct file *file = NULL;
>> +	int ret = -EBADF;
>> +
>> +	flags &= ~(MAP_EXECUTABLE | MAP_DENYWRITE);
>> +	if (!(flags & MAP_ANONYMOUS))
>> +		if (!(file = fget(fd))) {
>> +			printk(KERN_INFO "no fd in mmap\r\n");
>> +			goto out;
>> +		}
>> +
>> +	down_write(&current->mm->mmap_sem);
>> +	ret = do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
>> +	up_write(&current->mm->mmap_sem);
>> +	if (file)
>> +		fput(file);
>> +out:
>> +	return ret;
>> +}
>> +
>> +unsigned long sys_mmap2(unsigned long addr, size_t len,
>> +			unsigned long prot, unsigned long flags,
>> +			unsigned long fd, unsigned long pgoff)
>> +{
>> +	return do_mmap2(addr, len, prot, flags, fd, pgoff);
>> +}
>> +
>> +unsigned long sys_mmap(unsigned long addr, size_t len,
>> +			unsigned long prot, unsigned long flags,
>> +			unsigned long fd, off_t offset)
>> +{
>> +	int err = -EINVAL;
>> +
>> +	if (offset & ~PAGE_MASK) {
>> +		printk(KERN_INFO "no pagemask in mmap\r\n");
>> +		goto out;
>> +	}
>> +
>> +	err = do_mmap2(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
>> +out:
>> +	return err;
>> +}
> 
> Which mmap is uClibc really using? I suppose you only need mmap2, even for
> compatibility with any binary ever built for microblaze.

I don't know. Microblaze should be compiled with uClibc and glibc. In case you
need mmap2 for uClibc and mmap for glibc it is ok.

M

> 	Arnd <><
