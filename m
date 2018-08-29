From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 01/16] x86/cpu: create Dhyana init file and register new cpu_dev to system
Date: Wed, 29 Aug 2018 12:35:59 -0700
Message-ID: <87mut52cf4.fsf@linux.intel.com>
References: <cover.1535459012.git.puwen@hygon.cn>
        <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4610c537e5e5774d8d7486e0867ced8ebf0fba1.1535459012.git.puwen@hygon.cn>
        (Pu Wen's message of "Wed, 29 Aug 2018 20:42:49 +0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Pu Wen <puwen@hygon.cn> writes:

> Add x86 architecture support for new processor Hygon Dhyana Family 18h.
> Rework to create a separated file(arch/x86/kernel/cpu/hygon.c) from the
> AMD init one(arch/x86/kernel/cpu/amd.c) to initialize Dhyana CPU.

Standard approach would be to move the shared code into a different
file and call it from both amd.c and hygon.c instead of duplicating.

-Andi
