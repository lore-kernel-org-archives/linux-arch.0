From: Yanfei Wang <backyes@gmail.com>
Subject: How are cpu physical id & processor determined in /proc/cpuinfo ?
Date: Thu, 25 Jul 2013 00:09:48 +0800
Message-ID: <CAJULonjD9Rt1ObvC4S_V7pOkd78BT3LjzivBfPNpYrCDdLsJJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179]:59316 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab3GXQJt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jul 2013 12:09:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

We found that, the sequence of processor and physical id are not same
with different platform.

Conf 1:

6cores processor *2 with numa-enabled.
kernel 3.1.0
Ceontos 6.3

Conf 2:

6cores processor *2 with numa-enabled.
kernel 3.1.0
Ceontos 6.3

Conf 1 and Conf2 own same OS, kernel, and CPU, the sequences of
physical id from "cat /proc/cpuinfo" is not same.

Conf1 has sequence  with "cat /proc/cpuinfo |grep "physical id""
physical id:0
physical id:1
physical id:0
physical id:1
physical id:0
physical id:1
physical id:0
physical id:1
physical id:0
physical id:1
physical id:0
physical id:1
...
Conf2 has following sequence instead:
physical id:0
physical id:0
physical id:0
physical id:0
physical id:0
physical id:0
physical id:1
physical id:1
physical id:1
physical id:1
physical id:1
physical id:1

--------
different cpu physical id sequence can probably causes severe
numa-cross memory access for our program whose memory allocation
depends directly on the logical cpu id, rather than carefully get numa
node information with portable numa-API.

Any one can clarify our trouble, thanks a lot.

BR.
Yanfei Wang
