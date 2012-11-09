From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Fri, 9 Nov 2012 15:16:21 +0000
Message-ID: <201211091516.22018.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58898 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2KIPQ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 10:16:26 -0500
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:
> This patchset adds core architecture support to Linux for Imagination's
> Meta ATP (Meta 1) and HTP (Meta 2) processor cores. It is primarily an
> RFC patchset to get some early feedback about what changes we need to
> make, although of course all feedback is most welcome.
> 
> The patches are based on v3.6 for now, and can also be found in the
> following git tree:
>   git://github.com/jahogan/metag-linux.git metag-core
> 
> Meta cores are 32-bit, hardware multithreaded, general purpose, embedded
> processors which also feature a DSP instruction set, and can be found in
> many digital radios. They are capable of running different operating
> systems on different hardware threads, for example a digital radio might
> run RTOSes for DAB decoding and audio decoding on 3 hardware threads,
> and run Linux on the 4th hardware thread to manage the user interface,
> networking etc. HTPs are also capable of running SMP Linux on multiple
> hardware threads.
> 
> Instruction set and architecture overview documents can be found on the
> following page (these currently require registration/NDA, a restriction
> which was not intended and will shortly be removed):
>   http://www.imgtec.com/downloads.asp
> 

Hi James,

I'm finished with my initial review now. The code all looks reasonable
so far, I could find no show-stoppers and only had small comments.

What mainly seems to be missing here is platform specific support and
device drivers.  You are using the flattened device tree, which is good,
but don't have any example device tree files or new drivers, which makes
me wonder how you test the code ;-)

What are your plans around those?
I assume that the drivers are not ready yet and will follow later.

Do you expect a lot of device drivers to be shared with MIPS and ARM
based systems?

	Arnd
