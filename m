From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
Date: Tue, 9 Apr 2013 19:40:32 +0530
Message-ID: <51642158.3070205@synopsys.com>
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:64215 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab3DIOKz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Apr 2013 10:10:55 -0400
In-Reply-To: <515DBA0E.6000604@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org

On 04/04/2013 11:06 PM, Stephen Warren wrote:

> +.SECONDARY: $(obj)/%.dtb.S
> +
>  $(obj)/%.dtb.S: $(obj)/%.dtb
>         $(call cmd,dt_S_dtb)
> 
> and no longer see make rm'ing the .dtb.S file. So, the .SECONDARY is
> behaving as expected, and should fix your problem.

Interestingly, if I make the file name explicit, .SECONDARY works for me too.

.SECONDARY: $(obj)/angel4.dtb.S

http://stackoverflow.com/questions/5426934/why-this-makefile-removes-my-goal

Is this a make bug or is it related to when the rule is parsed by make !

-Vineet
