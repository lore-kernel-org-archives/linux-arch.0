Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbbC1XSb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Mar 2015 19:18:31 -0400
Message-ID: <551736C4.6080203@nod.at>
Date: Sun, 29 Mar 2015 00:18:28 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Question on ARC's thread_info
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "vgupta@synopsys.com" <vgupta@synopsys.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150328231828.VQbcGpm5WVEKdwcRYCd2-fLwoOcWexx_tUkzFveAyG8@z>

Vineet,

I'm working on a patch series which touches sturct thread_info.
ARC's thread_info has the following comment:
 * - if the contents of this structure are changed, the assembly constants
 *   must also be changed

Is this still true? Unless I'm reading the code wrong that case should be
handled automatically by the asm-offsets mechanism.
So no manual fixup of magic constants should be needed.

Thanks,
//richard
