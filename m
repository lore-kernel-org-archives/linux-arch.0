From: Michal Simek <monstr@monstr.eu>
Subject: Re: [RFC] status of execve() work - per-architecture patches solicited
Date: Mon, 17 Sep 2012 11:29:10 +0200
Message-ID: <5056ED66.30203@monstr.eu>
References: <20120907182004.GE13973@ZenIV.linux.org.uk>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120907182004.GE13973@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Al,

On 09/07/2012 08:20 PM, Al Viro wrote:
> 	To architecture maintainers: please, review the current
> situation in git.kernel.org/pub/scm/linux/kernel/git/viro/signal #execve2
> and consider sending the corresponding patches for missing architectures.

I have sent two patches. Please apply them to your tree.

Michal Simek (2):
       microblaze: Move restart allowed out of block
       microblaze: Remove compilation failure

  arch/microblaze/kernel/entry.S |    6 +++---
  1 files changed, 3 insertions(+), 3 deletions(-)

I have seen the compilation problem in June on linux-next but
have never got any response from you.
http://www.spinics.net/lists/linux-next/msg20848.html

Can you please apply these two patches to your tree?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
