Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:28820 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S964835AbWIKNdy
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 09:33:54 -0400
Received: from localhost.localdomain ([127.0.0.1]:52864 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038434AbWIKNdw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Sep 2006 14:33:52 +0100
Date: Mon, 11 Sep 2006 15:34:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC][PATCH] unify all architecture PAGE_SIZE definitions
Message-ID: <20060911133426.GA7952@linux-mips.org>
References: <20060824234445.6B519D52@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824234445.6B519D52@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 24, 2006 at 04:44:45PM -0700, Dave Hansen wrote:

+choice
+       prompt "Kernel Page Size"
+       depends on IA64 || SPARC64 || PARISC || MIPS
+       default PAGE_SIZE_4KB if MIPS

On MIPS we have a complicated set of rules for what page size is available
on which CPU and system Kconfig should know about that to avoid offering
options that result in non-functioning kernels.  That stuff should better
be kept under arch/mips than littering mm/Kconfig.

  Ralf
