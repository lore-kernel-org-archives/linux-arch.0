From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 45/56] microblaze_v2: headers simple files - empty or redirect to asm-generic
Date: Tue, 6 May 2008 09:38:27 -0600
Message-ID: <fa686aa40805060838x4bf281aenff1fb5d8eaa03f19@mail.gmail.com>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz>
	 <27d6acda14c492aae35d8bb1343a122624560418.1209897266.git.monstr@monstr.eu>
	 <64e6fc7378cd5c714fcceef7d4965c1fb3d1b288.1209897266.git.monstr@monstr.eu>
	 <9cc0d54a98f25748dc3f16fc3250524d7cd00877.1209897266.git.monstr@monstr.eu>
	 <5d240127ee05c28d5156bfbf305329f9540f6c14.1209897267.git.monstr@monstr.eu>
	 <59b5238f7a259dcac4c9ca6513756a188625462e.1209897267.git.monstr@monstr.eu>
	 <8e1d421649250f7a3f638cd552bc46e5f5845890.1209897267.git.monstr@monstr.eu>
	 <1209954849.5798.80.camel@localhost>
	 <20080507004702.d516a727.sfr@canb.auug.org.au>
	 <482077FE.7080201@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:20769 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759944AbYEFPi2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 May 2008 11:38:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so659458and.103
        for <linux-arch@vger.kernel.org>; Tue, 06 May 2008 08:38:27 -0700 (PDT)
In-Reply-To: <482077FE.7080201@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au

On Tue, May 6, 2008 at 9:23 AM, Michal Simek <monstr@seznam.cz> wrote:
> Hi,
>
>
>
>  > On Mon, 05 May 2008 12:34:09 +1000 John Williams <john.williams@petalogix.com> wrote:
>  >>
>  >>>  include/asm-microblaze/auxvec.h            |   14 ++++++++++++++
>  >>>  include/asm-microblaze/cputime.h           |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/div64.h             |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/emergency-restart.h |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/errno.h             |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/futex.h             |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/kdebug.h            |   19 +++++++++++++++++++
>  >>>  include/asm-microblaze/local.h             |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/mutex.h             |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/namei.h             |   24 ++++++++++++++++++++++++
>  >>>  include/asm-microblaze/percpu.h            |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/resource.h          |   16 ++++++++++++++++
>  >>>  include/asm-microblaze/user.h              |   18 ++++++++++++++++++
>  >> These are all just includes of asm-generic/* (hooray!).
>  >
>  > Absolutely, but is it really necessary to have 14-16 lines of comment
>  > (including a copyright notice) for a file whose single real line is just
>  > to include another file?  i.e. reduce all these to 1 line files.
>
>  Can I do it? I think every file need license.

Its pretty hard to claim copyright rights on a single source line of code.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
