Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Feb 2005 13:54:42 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] Fix compat shmget overflow
Message-ID: <20050209125442.GB27875@linux-mips.org>
References: <20050209094428.GB23943@wotan.suse.de> <OF57C10E69.8B803A13-ON41256FA3.00360882-41256FA3.0037BF5D@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF57C10E69.8B803A13-ON41256FA3.00360882-41256FA3.0037BF5D@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, corryk@us.ibm.com, linux-arch@vger.kernel.org, anton@samba.org, davem@davemloft.net
List-ID: <linux-arch.vger.kernel.org>

On Wed, Feb 09, 2005 at 11:08:54AM +0100, Martin Schwidefsky wrote:

> > This fixes an incorrect sign extension in the compat layer that
> > breaks 32bit shmget that are >2GB. sys_shmget has a signed size_t size
> > argument, and the int size argument comming from 32bit user space would
> get
> > sign extended to 64bit, which is wrong.
> 
> Ok for s390 though not needed. The address space for a 31 bit programs
> is limited to 2GB anyway.

Same on MIPS.

  Ralf
