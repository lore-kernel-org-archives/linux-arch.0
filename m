Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:28162 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933788Ab3DPPxs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Apr 2013 11:53:48 -0400
Message-ID: <516D7405.3060202@imgtec.com>
Date: Tue, 16 Apr 2013 16:53:41 +0100
From: James Hogan <james.hogan@imgtec.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com> <5168822C.6040303@wwwdotorg.org>
In-Reply-To: <5168822C.6040303@wwwdotorg.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20130416155341.xhdDcT5uatsKP3iX6fF08_a3vbQ6Hp-QbDFpz2IBXXE@z>

On 12/04/13 22:52, Stephen Warren wrote:
> +.SECONDARY: $(obj)/$(builtindtb-y).dtb.S

Note, this may not work if you're using CONFIG_ARC_BUILTIN_DTB_NAME,
since it'll have quotes around it, so you may instead need:
.SECONDARY: $(obj)/$(patsubst "%",%,$(builtindtb-y)).dtb.S

(at least that's what's required for the metag equivalent)

> +
>  dtbs:  $(addprefix  $(obj)/, $(builtindtb-y).dtb)

You might find the same thing here too.

Cheers
James

