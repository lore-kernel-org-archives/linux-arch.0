From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [tip:x86/vdso] clocksource: Replace vread with generic arch data
Date: Thu, 21 Jul 2011 14:25:13 -0700
Message-ID: <4E289939.2080004@zytor.com>
References: <3ae5ec76a168eaaae63f08a2a1060b91aa0b7759.1310563276.git.luto@mit.edu> <tip-433bd805e5fd2c731b3a9025b034f066272d336e@git.kernel.org> <4E288AA6.7090804@zytor.com> <CAObL_7HyKSwm9a_7nfdk5E0Noy5zqD=dyaanvxY_iX5XcP1d4Q@mail.gmail.com> <4E28934A.6040200@zytor.com> <CAObL_7Gpf8Ux=unueB5y41p=O2dHPjZ_eVW+g6Es8N6TH4nLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60831 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1GUVZl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Jul 2011 17:25:41 -0400
In-Reply-To: <CAObL_7Gpf8Ux=unueB5y41p=O2dHPjZ_eVW+g6Es8N6TH4nLXg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Lutomirski <luto@mit.edu>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, johnstul@us.ibm.com, tony.luck@intel.com, fenghua.yu@intel.com, tglx@linutronix.de, hpa@linux.intel.com, clemens@ladisch.de, linux-tip-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linux Arch Mailing List <linux-arch@vger.kernel.org>

On 07/21/2011 02:22 PM, Andrew Lutomirski wrote:
> 
> Presumably this needs a matching fix:
> 
> http://git.kernel.org/?p=linux/kernel/git/tip/linux-tip.git;a=commit;h=574c44fa8fa6262ffd5939789ef51a6e98ed62d7
> 
> (Also, none of the IA-64 maintainers have replied to any of my
> requests for review.)
> 

What do you mean, "matching fix"?  The fix I posted should work on x86
and ia64.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
