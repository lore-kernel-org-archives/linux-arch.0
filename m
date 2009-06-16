From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: Representing Embedded Architectures at the Kernel Summit
Date: Tue, 16 Jun 2009 09:42:46 +0300
Message-ID: <4A373EE6.6070201@compulab.co.il>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from legaljet.webserversystems.com ([67.18.134.218]:36843 "EHLO
	compulab.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbZFPIDH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jun 2009 04:03:07 -0400
In-Reply-To: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org



James Bottomley wrote:
> Hi All,
> 
> We've got to the point where there are simply too many embedded
> architectures to invite all the arch maintainers to the kernel summit.
> So, this year, we thought we'd do embedded via topic driven invitations
> instead.  So what we're looking for is a proposal to discuss the issues
> most affecting embedded architectures, or preview any features affecting
> the main kernel which embedded architectures might need ... or any other
> topics from embedded architectures which might need discussion or
> debate.

Another issue that affects embedded architectures is drivers initialization
order. There are a lot of cases when you need the drivers to be initialized in
particular order, and current initcalls scheme does not allow fine grained
control for it.

-- 
Sincerely yours,
Mike.
