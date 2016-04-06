Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:46830 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754772AbcDFIbH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2016 04:31:07 -0400
Date: Wed, 6 Apr 2016 10:24:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH V2 01/30] bitops: add parity functions
Message-ID: <20160406082458.GA1202@ravnborg.org>
References: <57031D9D.801@gmail.com>
 <20160405190432.GA28532@ravnborg.org>
 <57049FAF.4040804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57049FAF.4040804@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160406082458.ElzdaxVE5ayrP06gU5OJxwjqE9s9bFlwJLgg6OtKr5k@z>

On Wed, Apr 06, 2016 at 01:33:35PM +0800, Zeng Zhaoxiu wrote:
> 在 2016年04月06日 03:04, Sam Ravnborg 写道:
> >On Tue, Apr 05, 2016 at 10:06:21AM +0800, Zeng Zhaoxiu wrote:
> >>From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> >>
> >>These patches provide generic and architecture-specific odd parity
> >>calculations.
> >Hi Zeng.
> >
> >Can you please fix your mail script.
> >I see only 1/30 (sent to linux-arch) - and patch looks mangeled (broken lines)
> >No mail was sent to sparclinux - but sparc was mentioned.
> >
> >git send-mail usually do the trick.
> >
> >	Sam
> 
> When I do "git send-email", I got:
> ...
> 5.7.14 JTibJDWdGxPcfa-E9KgtF-grMQl9w> Please log in via your web browser and
> 5.7.14 then try again.
> 5.7.14  Learn more at
> 5.7.14  https://support.google.com/mail/answer/78754 zp5sm464879pac.9 - gsmtp
> ...
> 
> So I use thunderbird to send email, but the text wrap error.
Please try to search for "How to configure git send-email to use Gmail"
and follow the instructions given in some of the links.
Test with your own mail address before you send to a list.

Also linux-arch only saw 1/30 - make sure to address this too.

	Sam
