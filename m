From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 03/44] Add CONFIG_HAVE_64BIT_ALIGNED_STRUCT for taskstats
Date: Fri, 07 Dec 2012 19:43:13 -0800
Message-ID: <50C2B751.5000507@zytor.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com> <1354723742-6195-4-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44935 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932887Ab2LHDn1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Dec 2012 22:43:27 -0500
In-Reply-To: <1354723742-6195-4-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Balbir Singh <bsingharora@gmail.com>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Eric Paris <eparis@redhat.com>, Will Drewry <wad@chromium.org>, James Morris <james.l.morris@oracle.com>

On 12/05/2012 08:08 AM, James Hogan wrote:
> On 64 bit architectures with no efficient unaligned access, taskstats
> has to add some padding to a reply to prevent unaligned access warnings.
> However this also needs to apply to 32 bit architectures with 64 bit
> struct alignment such as metag (which has 64 bit memory accesses).

Wait... 64-bit struct alignment on structures with only 32-bit members? 
  That might be... interesting... in a number of places...

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
