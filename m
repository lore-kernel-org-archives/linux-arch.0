Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:14016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263847AbUDPVoS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Apr 2004 17:44:18 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i3GLiGJW019315
	for <linux-arch@vger.kernel.org>; Fri, 16 Apr 2004 17:44:16 -0400
Date: Fri, 16 Apr 2004 14:43:43 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: Unexpected syscalls on 64-bit arches
Message-Id: <20040416144343.7bbeecd6.davem@redhat.com>
In-Reply-To: <20040416210802.GU31589@devserv.devel.redhat.com>
References: <20040416210802.GU31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 16 Apr 2004 17:08:03 -0400
Jakub Jelinek <jakub@redhat.com> wrote:

> At least from glibc's point of view, these syscalls will never be used
> on 64-bit arches, so IMHO they should be at least killed from the
> unistd.h headers to avoid confusion and maybe nuked from the syscall tables
> as well.

I agree perhaps about unistd.h removal, but there is danger that some
binary might invoke it so better not remove it from the syscall
tables.
