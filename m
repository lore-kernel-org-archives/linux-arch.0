From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 00/16] Revert h8300 archtecture support
Date: Mon, 9 Mar 2015 22:55:22 -0700
Message-ID: <20150310055522.GA9699@roeck-us.net>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45511 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbCJFzj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Mar 2015 01:55:39 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YVD8k-001F2E-HV
	for linux-arch@vger.kernel.org; Tue, 10 Mar 2015 05:55:38 +0000
Content-Disposition: inline
In-Reply-To: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Mar 09, 2015 at 05:46:54PM +0900, Yoshinori Sato wrote:
> Hello.
> 
> I rewriting h8300 support.
> 

It might possibly be better to use the term "re-introduce" instead of
rewrite or revert (as in the headline).

Also,
	s/archtecture/architecture/

in the headline.

Given that the reason for dropping the architecture in the first place was
the lack of an active maintainer, I am somewhat surprised that you don't
add one to the MAINTAINERS file.

Guenter
