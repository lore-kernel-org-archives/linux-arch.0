From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 09/37] firewire: use get/put_endian helpers
Date: Fri, 30 May 2008 01:34:27 +0200
Message-ID: <483F3D83.80206@s5r6.in-berlin.de>
References: <1212092292.28403.111.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:55797 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbYE2Xeo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 19:34:44 -0400
In-Reply-To: <1212092292.28403.111.camel@brick>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

Harvey,

a minor side note:  A pointer to your patch which adds the helpers would 
have saved me 10 minutes of my life.  I wasn't up to speed where this 
API is available.

I.e. please add "requires patch $FOOBAR" below the --- delimiter when 
you post dependent and depending patch to different addresses.
-- 
Stefan Richter
-=====-==--- -=-= ====-
http://arcgraph.de/sr/
