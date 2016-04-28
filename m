From: Christopher Covington <cov@codeaurora.org>
Subject: VDSO unmap and remap support for additional architectures
Date: Thu, 28 Apr 2016 11:18:52 -0400
Message-ID: <1461856737-17071-1-git-send-email-cov@codeaurora.org>
References: <20151202121918.GA4523@arm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151202121918.GA4523@arm.com>
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

Please take a look at the following prototype of sharing the PowerPC
VDSO unmap and remap code with other architectures. I've only hooked
up arm64 to begin with. If folks think this is a reasonable approach I
can work on 32 bit ARM as well. Not hearing back from an earlier
request for guidance [1], I simply dove in and started hacking.
Laurent's test case [2][3] is a compelling illustration of whether VDSO
remap works or not on a given architecture.

1. https://lkml.org/lkml/2016/3/2/225
2. https://lists.openvz.org/pipermail/criu/2015-March/019161.html
3. http://lists.openvz.org/pipermail/criu/attachments/20150318/f02ed9ea/attachment.bin

Thanks,
Christopher Covington

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
