From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 01/14] Introduce cpu_enabled_map and friends
Date: Tue, 15 Jul 2008 12:16:32 -0600
Message-ID: <20080715181632.GG14894@parisc-linux.org>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023349.2528.9423.stgit@blender.achiang> <20080715031512.GF14894@parisc-linux.org> <87wsjnxy4w.fsf@basil.nowhere.org> <20080715102130.GA22866@flint.arm.linux.org.uk> <20080715175740.GB10919@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080715175740.GB10919@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 15, 2008 at 11:57:40AM -0600, Alex Chiang wrote:
> My thought was that big SMP systems like ia64, possibly sparc and
> ppc, and increasingly, x86, might find something like this
> useful, as systems get larger and larger, and vendors are going
> to want to do RAS-ish features, like the ability to keep CPUs in
> firmware across reboots until told otherwise by the sysadmin.
> 
> Right now, a 'present' CPU strongly implies 'online' as well,
> since we're calling cpu_up() for all 'present' CPUs in
> smp_init(). But this hurts if:
> 
> 	- you don't actually want to bring up all 'present' CPUs
> 	- you still want to interact with these weirdo zombie
> 	  CPUs that are 'present' but not 'online'

Have you considered simply failing __cpu_up() for CPUs that are
deconfigured by firmware?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
