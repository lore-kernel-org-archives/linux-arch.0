Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from viefep12-int.chello.at ([62.179.121.32]:4549 "EHLO
	viefep12-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbZJHKdA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2009 06:33:00 -0400
Subject: Re: [v8 PATCH 2/8]: cpuidle: implement a list based approach to
 register a set of idle routines.
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <20091008095027.GC20595@linux.vnet.ibm.com>
References: <20091008094828.GA20595@linux.vnet.ibm.com>
	 <20091008095027.GC20595@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Oct 2009 12:36:02 +0200
Message-ID: <1254998162.26976.270.camel@twins>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arun@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>, Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
Message-ID: <20091008103602.zqvKLNNuDscupOxOh4OrLqg41hWZCjoLig6v7lO0OqY@z>

On Thu, 2009-10-08 at 15:20 +0530, Arun R Bharadwaj wrote:
> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-10-08 15:18:28]:
> 
> Implement a list based registering mechanism for architectures which
> have multiple sets of idle routines which are to be registered.
> 
> Currently, in x86 it is done by merely setting pm_idle = idle_routine
> and managing this pm_idle pointer is messy.
> 
> To give an example of how this mechanism works:
> In x86, initially, idle routine is selected from the set of poll/mwait/
> c1e/default idle loops. So the selected idle loop is registered in cpuidle
> as one idle state cpuidle devices. Once ACPI comes up, it registers
> another set of idle states on top of this state. Again, suppose a module
> registers another set of idle loops, it is added to this list.
> 
> This provides a clean way of registering and unregistering idle state
> routines.

So cpuidle didn't already have a list of idle functions it takes an
appropriate one from?

Then what does this governor do?

Also, does this imply the governor doesn't consider these idle routines?

