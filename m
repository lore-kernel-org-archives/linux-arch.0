Return-Path: <glauber@gmx.de>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:26862 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264057AbUDVOAE
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 10:00:04 -0400
Subject: Re: [Patch] SMP call function cleanup
From: Jan Glauber <glauber@gmx.de>
Reply-To: glauber@gmx.de
In-Reply-To: <20040422122818.GR743@holomorphy.com>
References: <1082636511.1332.34.camel@halo>
	 <20040422122818.GR743@holomorphy.com>
Content-Type: text/plain
Message-Id: <1082642295.1333.54.camel@halo>
Mime-Version: 1.0
Date: Thu, 22 Apr 2004 15:58:15 +0200
Content-Transfer-Encoding: 7bit
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Architecture List <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 14:28, William Lee Irwin III wrote:

> Any chance we could get an smp_call_function_cpumask()?
That's what I propesed with on_cpu(). I don't care how we name this
function, but I found the smp_call_function_on_whatever
names a bit too long.

Jan

---
Jan Glauber
Linux on zSeries Development
IBM Deutschland Entwicklung GmbH
Phone: +49 7031 161911   Mail: jang@de.ibm.com
