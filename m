Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:33471 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab3DQEPV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Apr 2013 00:15:21 -0400
Message-ID: <516E21C8.5040908@synopsys.com>
Date: Wed, 17 Apr 2013 09:45:04 +0530
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Kbuild: Avoid DTB rebuilds if source files are untouched
References: <1364973141-16354-1-git-send-email-vgupta@synopsys.com> <515BD6B8.1020607@synopsys.com> <515C5652.8070705@wwwdotorg.org> <515D0FFB.4030803@synopsys.com> <515DBA0E.6000604@wwwdotorg.org> <51642158.3070205@synopsys.com> <5167BA67.5080403@synopsys.com> <5168822C.6040303@wwwdotorg.org> <516D7405.3060202@imgtec.com> <516D7600.4080002@imgtec.com>
In-Reply-To: <516D7600.4080002@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org, Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20130417041504.a75Xyu1RMVKciHy66sZivaB6jtmyMEFYnJZU2BLUh2k@z>

On 04/16/2013 09:32 PM, James Hogan wrote:
>
> Also, I think you probably now want *.dtb.S added to clean-files,
> otherwise they won't get removed by make clean.

Good catch !

Thx,
-Vineet
