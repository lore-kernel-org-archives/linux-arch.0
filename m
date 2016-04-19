Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.horizon.com ([71.41.210.147]:26463 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933183AbcDSSvn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Apr 2016 14:51:43 -0400
Date: 19 Apr 2016 14:45:01 -0400
Message-ID: <20160419184501.13069.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH V3 01/29] bitops: add parity functions
In-Reply-To: <1460601694-4056-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, zengzhaoxiu@163.com
Cc: akpm@linux-foundation.org, arnd@arndb.de, dvlasenk@redhat.com, linux-arch@vger.kernel.org, linux@horizon.com, martink@posteo.de, mingo@kernel.org, sasha.levin@oracle.com, yury.norov@gmail.com, zhaoxiu.zeng@gmail.com
Message-ID: <20160419184501.kf9ZNDpsZQsyvzmPSMhUPlY_nEGZAhXlqLs1hm36txg@z>

> Add generic odd parity functions, adapted from
> "https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel"

Given a PARITY_MAGIC of 0x6996, this is even parity, not odd.

(Which it should be; an XOR of all bits is the "natural" form.)
