From: Vineet Gupta <vineet.gupta1@synopsys.com>
Subject: Re: [PATCH 1/2] ARC: show_regs: avoid page allocator
Date: Thu, 20 Dec 2018 18:36:36 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642385B@US01WEMBX2.internal.synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-2-git-send-email-vgupta@synopsys.com>
 <1545239047.14089.13.camel@synopsys.com>
 <49f9edc9-87ee-1efc-58f8-b0d9a52c8a49@synopsys.com>
 <e2d2c160-0ef6-5504-7824-032a5c70fa7f@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/20/18 5:30 AM, Tetsuo Handa wrote:=0A=
>> |  mmput+0x16/0xb8=0A=
> Then, does mmput_async() help?=0A=
=0A=
Probably, I can try.=0A=
