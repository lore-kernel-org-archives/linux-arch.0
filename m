From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Date: Thu, 20 Dec 2018 18:38:26 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642386D@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <20181220125730.GA17350@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On 12/20/18 4:57 AM, Michal Hocko wrote:=0A=
>> Despite this, lockdep still barfs (see next change), but this patch=0A=
>> still has merit as in we use smaller/localized buffers now and there's=
=0A=
>> less instructoh trace to sift thru when debugging pesky issues.=0A=
> But show_regs is called from contexts which might be called from deep=0A=
> call chains (e.g WARN). Is it safe to allocate such a large stack there?=
=0A=
=0A=
ARC has 8K pages and 256 additional bytes of stack usage doesn't seem absur=
dly=0A=
high to me !=0A=
=0A=
-Vineet=0A=
