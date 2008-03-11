Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:51702 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbYCKKDB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Mar 2008 06:03:01 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Tue, 11 Mar 2008 11:02:51 +0100
References: <200803071326.06682.borntraeger@de.ibm.com> <200803110810.49759.borntraeger@de.ibm.com> <je7ig9hag4.fsf@sykes.suse.de>
In-Reply-To: <je7ig9hag4.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-ID: <200803111102.51653.borntraeger@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Avi Kivity <avi@qumranet.com>, Sam Ravnborg <sam@ravnborg.org>, kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, mm-commits@vger.kernel.org
Message-ID: <20080311100251.zGjZs7E_lAiFgMbDKys7CQYt4N_ftfBGFbLzlvvNj_Y@z>

Am Dienstag, 11. März 2008 schrieb Andreas Schwab:
> Christian Borntraeger <borntraeger@de.ibm.com> writes:
> 
> >  include/asm-alpha/kvm.h        |    6 ++++++
> 
> Can't you put it in asm-generic?

I dont think so. The generic part is in include/linux/kvm.h. asm/kvm.h is 
populated by each architecture which gets kvm support with arch specfic 
definitions. x86 has support and s390, powerpc and ia64 are currently know 
to work on ports. 


Christian
