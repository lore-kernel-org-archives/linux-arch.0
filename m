From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 11/28] ARCv2: extable: Enable sorting at build time
Date: Tue, 30 Jun 2015 10:11:41 +0530
Message-ID: <55921E05.40000@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com> <1433850508-26317-12-git-send-email-vgupta@synopsys.com> <558A4559.1070304@synopsys.com> <5591ACE2.8050000@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:54012 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbbF3El6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 30 Jun 2015 00:41:58 -0400
In-Reply-To: <5591ACE2.8050000@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com

On Tuesday 30 June 2015 02:08 AM, David Daney wrote:
>>
>> Sorry for missing you in the CC in orig post of this patch. Can I get your Ack on
>> this one !
>>
> 
> OK:
> 
> Acked-by: David Daney <david.daney@cavium.com>

Thx David. Although I had put the patch as it is in the end as I need to send a
pull request to Linus soon for hat stuff.


> Really this is obvious, and only effects ARCv2, so the corresponding maintainers
> shouldn't need my Ack.

Indeed it was obvious, but last few commits in that file had ACK's from you so I
thought of retaining the tradition so to speak :-)

-Vineet
