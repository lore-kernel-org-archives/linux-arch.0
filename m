Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Feb 2005 11:31:39 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix compat shmget overflow
Message-ID: <20050209103139.GA3387@wotan.suse.de>
References: <20050209094428.GB23943@wotan.suse.de> <OF57C10E69.8B803A13-ON41256FA3.00360882-41256FA3.0037BF5D@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF57C10E69.8B803A13-ON41256FA3.00360882-41256FA3.0037BF5D@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, corryk@us.ibm.com, linux-arch@vger.kernel.org, anton@samba.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

> As you mention sys_shmget, I'm currently trying to find out why the
> second argument of sys_ipc for ppc64, s390-64 and sparc64 has been
> changed from "long" to "int". This limits the maximum size of a shared
> memory segment to 2GB for the three archs. A cast to unsigned would
> allow 4GB, still not enough for a 64 bit architecture in the long run.
> Before I submit a patch to replace "int" with "long" again I'd like
> to understand the reason for the change.

I don't know. Look up the Cset at linux.bkbits.net and if it's not clear
from the description ask the submitter? 

-Andi
