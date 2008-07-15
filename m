From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 01/14] Introduce cpu_enabled_map and friends
Date: Mon, 14 Jul 2008 21:15:12 -0600
Message-ID: <20080715031512.GF14894@parisc-linux.org>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023349.2528.9423.stgit@blender.achiang>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:46812 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbYGODP3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2008 23:15:29 -0400
Content-Disposition: inline
In-Reply-To: <20080715023349.2528.9423.stgit@blender.achiang>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jul 14, 2008 at 08:33:49PM -0600, Alex Chiang wrote:
> Currently, the following cpu maps exist:
> 
> 	cpu_possible_map - map of populatable CPUs
> 	cpu_present_map  - map of populated CPUs
> 	cpu_online_map   - map of schedulable CPUs
> 
> These maps do not provide the concept of populated, but disabled CPUs.
> 
> That is, a system may contain CPU modules that are physically plugged
> in, but disabled by system firmware.

I don't understand why we want to know about these CPUs.  Surely they
should be 'possible', but not 'present'?  What useful thing can Linux do
with them?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
