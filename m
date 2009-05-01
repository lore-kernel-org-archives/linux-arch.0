From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: "N" symbols and System.map
Date: Fri, 01 May 2009 15:24:18 -0700
Message-ID: <49FB7692.2000508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:60787 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1763911AbZEAWYT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 18:24:19 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

Hi all,

right now, we filter out symbols that nm tag N, meaning "debugging 
symbols", from System.map.  However, at least on x86, the 
linker-generated symbol _end is tagged N, and in fact is the only N in 
the entire image.

Are there other architectures which would suffer if N were included in 
System.map, or would that be a reasonable thing to do?

	-hpa
