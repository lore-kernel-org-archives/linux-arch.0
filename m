From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Heads up: cpumask changes
Date: Wed, 19 Nov 2008 00:30:10 +1030
Message-ID: <200811190030.10550.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52326 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbYKROAT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Nov 2008 09:00:19 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Mike Travis <travis@sgi.com>

Hi all,

   With large NR_CPUS coming, Mike and I have been working to make dynamic 
cpumasks an option.  The main change is to APIs which pass cpumask_t around; 
they'll now be '[const] struct cpumask *'.  This unfortunately will hit arch 
code as interfaces get frobbed, and a couple of nasty one-shot transitions are 
unavoidable.

   For archs which never intend to support CONFIG_CPUMASK_OFFSTACK, the rest 
of the changes will be cosmetic (eg. s/cpumask_t/struct cpumask/ eventually).  
For x86 and others who allow CONFIG_CPUMASK_OFFSTACK, "struct cpumask" will 
eventually be undefined so it cannot be assigned or used on the stack: this 
means use cpumask_copy(), cpumask_var_t and as a last resort, 
DEFINE_BITMAP(bitmap, NR_CPUS) and to_cpumask(bitmap).

   We've been working most closely with Ingo, as x86, irq and scheduler are 
most effected.  Apologies in advance for the churn, but the final result will 
be a neater API than what we have now as well as stupid numbers of cpus in 
your .config.

Thanks!
Rusty.
