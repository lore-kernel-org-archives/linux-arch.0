Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:64066 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeCIQbn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Mar 2018 11:31:43 -0500
Date: Fri, 9 Mar 2018 16:31:36 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: Re: RFC: remove the "tile" architecture from glibc
In-Reply-To: <9a60ac70-21e4-3f48-5cd7-ffd3aabc5c21@physik.fu-berlin.de>
Message-ID: <alpine.DEB.2.20.1803091622420.8457@digraph.polyomino.org.uk>
References: <1a57be83-3349-5450-ee4f-d2a33569a728@mellanox.com> <d6c8e425-a6b6-6594-05e3-965536f06da3@physik.fu-berlin.de> <abce89d0-6798-069a-1a54-06e664665b78@mellanox.com> <dc3c52ce-f082-0da0-7828-0d4e6751e2a5@physik.fu-berlin.de>
 <CAK8P3a3itR8i2ayG7e4ku7kz+CQU7qHhptdmtmgTz+CzFGmCiw@mail.gmail.com> <20180307181407.GA24350@alf.mars> <CAK8P3a2VuYxzy6RmL_w_5f2qHepVRhfVR5P4x9nCUYav1s5n7g@mail.gmail.com> <9a60ac70-21e4-3f48-5cd7-ffd3aabc5c21@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Helmut Grohne <helmut@subdivi.de>, GNU C Library <libc-alpha@sourceware.org>, linux-arch <linux-arch@vger.kernel.org>, metcalf@alum.mit.edu, Henrik Grindal Bakken <hgb@ifi.uio.no>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180309163136.hSRrEFLI9ES_W5t7z67U4A3YByFheY1k3k5ExLHnvK4@z>

On Thu, 8 Mar 2018, John Paul Adrian Glaubitz wrote:

> I have personally invested a lot of work into the SH port over the
> past three years in Debian and I was involved fixing many bugs
> and as a result, the port is quite usable. It would be really
> disappointing to see it being removed all of a sudden :(.

Note that SH glibc test results need some work - there are a large number 
of failures listed at <https://sourceware.org/glibc/wiki/Release/2.27#SH>.  
Probably most could be addressed with the NaN fixes I outlined at 
<https://sourceware.org/ml/libc-alpha/2018-02/msg00440.html> - but that 
does of course need someone to do the work to implement that in GCC and 
glibc.  (The stdlib/tst-tininess failure is stranger; SH manuals don't 
seem very specific on this, but the existing setting was definitely 
determined by testing on hardware.  SH experts with access to a range of 
different hardware may be needed to advise on what different hardware does 
or is supposed to do in this regard.)

The glibc port whose test results cause me the most concern that it's 
effectively unmaintained and should be considered for obsoletion is 
MicroBlaze - the results 
<https://sourceware.org/glibc/wiki/Release/2.27#MicroBlaze> are clearly a 
big mess (not something where one fix would probably resolve most failures 
as on SH) and there's no sign of activity to sort them out (nor has there 
been such activity for a long time).

-- 
Joseph S. Myers
joseph@codesourcery.com
