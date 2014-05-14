Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:58465 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbaENQe2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 May 2014 12:34:28 -0400
Message-ID: <537396F9.3090704@imgtec.com>
Date: Wed, 14 May 2014 17:16:57 +0100
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [RFC 3/3] asm-generic: Drop renameat syscall from default list
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>	<1398247687-13453-4-git-send-email-james.hogan@imgtec.com>	<201404231418.05174.arnd@arndb.de>	<CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com> <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
In-Reply-To: <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Szeredi Miklos <miklos@szeredi.hu>
Cc: Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <mszeredi@suse.cz>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, metag <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, linux@openrisc.net, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20140514161657.8nWf8AD_onWE-ifdNA_mlR949wqdDv-vXAGMoKTCSFc@z>

Hi Miklos,

On 29/04/14 12:24, Szeredi Miklos wrote:
> On Wed, Apr 23, 2014 at 2:41 PM, James Hogan <james.hogan@imgtec.com> wrote:
> 
>> It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
>> syscall to asm-generic unistd.h), and will be submitting it to Linus
>> at some point as part of his renameat2 series.
>> Miklos: Do you think it makes sense for you to include my second patch
>> in your series too since it's renameat2 related?
>> http://marc.info/?l=linux-kernel&m=139824773305016&w=2
> 
> I've queued up the first two patches with acks from Arnd.

Were you planning to send a pull request for your renameat2 patches for
v3.15?

Cheers
James
