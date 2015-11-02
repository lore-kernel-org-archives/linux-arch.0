From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH 0/5] 64-by-32 ddivision optimization for constant divisors on
 32-bit machines
Date: Mon, 02 Nov 2015 17:33:25 -0500
Message-ID: <1446503610-6942-1-git-send-email-nicolas.pitre@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>
Cc: Arnd Bergmann <arnd@arndb.de>, rmk+kernel@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is a generalization of the optimization I produced for ARM a decade
ago to turn constant divisors into a multiplication by the divisor
reciprocal. Turns out that after all those years gcc is still not
optimizing things on its own for that case.

This has important performance benefits as discussed in this thread:

https://lkml.org/lkml/2015/10/28/851

This series brings the formerly ARMonly optimization to all 32-bit
architectures using C code by default.  The possibility for the actual
multiplication to be implemented in assembly is provided in order to get
optimal code.  The ARM version can be used as an example implementation
for other interested architectures to implement.


Nicolas
