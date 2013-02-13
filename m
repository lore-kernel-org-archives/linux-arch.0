From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: ksignal changes for 3.9
Date: Wed, 13 Feb 2013 12:06:30 +0530
Message-ID: <511B346E.2090900@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp2.synopsys.com ([198.182.44.80]:37293 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab3BMGhK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2013 01:37:10 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>

Hi Al,

linux-next contains ksignal conversion for some of the architectures. Are you
planning to complete that in 3.9 merge window. The reason I ask is so that the
newer architectures (arc/metag - for a likely 3.9 merge) can queue the
corresponding changes via respective trees.

Thx,
-Vineet
