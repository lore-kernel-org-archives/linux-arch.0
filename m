Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9676 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964910AbWJ1XMS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Oct 2006 19:12:18 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9SNCH7h028434
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 19:12:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k9SNCHVB105954
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 19:12:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k9SNCG6Y029147
	for <linux-arch@vger.kernel.org>; Sat, 28 Oct 2006 19:12:17 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: Generic compat_sys_rt_sigqueueinfo
Date: Sun, 29 Oct 2006 01:12:14 +0200
References: <20061028223730.GC3243@athena.road.mcmartin.ca> <200610290109.08844.arnd.bergmann@de.ibm.com>
In-Reply-To: <200610290109.08844.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610290112.15031.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 29 October 2006 01:09, Arnd Bergmann wrote:
> Since sys_rt_sigqueueinfo() is so simple, I think it would be much
> better to define the common version as 
> 
> asmlinkage long
> sys_rt_sigqueueinfo(int pid, int sig, siginfo_t __user *uinfo)

that should read compat_sys_rt_sigqueueinfo, of course.

	Arnd <><
