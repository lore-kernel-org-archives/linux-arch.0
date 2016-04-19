From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH V3 01/29] bitops: add parity functions
Date: 19 Apr 2016 14:45:01 -0400
Message-ID: <20160419184501.13069.qmail@ns.horizon.com>
References: <1460601694-4056-1-git-send-email-zengzhaoxiu@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460601694-4056-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, zengzhaoxiu@163.com
Cc: akpm@linux-foundation.org, arnd@arndb.de, dvlasenk@redhat.com, linux-arch@vger.kernel.org, linux@horizon.com, martink@posteo.de, mingo@kernel.org, sasha.levin@oracle.com, yury.norov@gmail.com, zhaoxiu.zeng@gmail.com
List-Id: linux-arch.vger.kernel.org

> Add generic odd parity functions, adapted from
> "https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel"

Given a PARITY_MAGIC of 0x6996, this is even parity, not odd.

(Which it should be; an XOR of all bits is the "natural" form.)
