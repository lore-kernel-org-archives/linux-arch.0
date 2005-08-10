Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 10 Aug 2005 09:28:05 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH] consolidate sys_ptrace
Message-ID: <20050810132805.GA3821@ccure.user-mode-linux.org>
References: <20050810080057.GA5295@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810080057.GA5295@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Aug 10, 2005 at 10:00:57AM +0200, Christoph Hellwig wrote:
> The sys_ptrace boilerplate code (everything outside the big switch
> statement for the arch-specific requests) is shared by most
> architectures.  This patch moves it to kernel/ptrace.c and leaves the
> arch-specific code as arch_ptrace.

OK for UML.

		Jeff
