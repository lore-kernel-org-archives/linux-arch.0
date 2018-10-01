From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v6 16/16] cpupower, x86: Add Hygon Dhyana support
Date: Mon, 1 Oct 2018 13:38:32 -0600
Message-ID: <8db5f167-3dec-5342-5430-ade222848c74@kernel.org>
References: <cover.1536550549.git.puwen@hygon.cn>
 <c26bcce9f41bee8b6921f67e6171a49b17010b8d.1536550550.git.puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c26bcce9f41bee8b6921f67e6171a49b17010b8d.1536550550.git.puwen@hygon.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, bp@alien8.de, pbonzini@redhat.com, trenn@suse.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>
List-Id: linux-arch.vger.kernel.org

On 09/10/2018 07:20 AM, Pu Wen wrote:
> Tool cpupower is useful to get CPU frequency information and monitor
> power stats on Hygon Dhyana platforms. So add Hygon Dhyana support to
> it by checking vendor and family to share the code path of AMD family
> 17h.
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>

Looks good to me. I am assuming it will go into x86 with the rest of the
series.

Acked-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>

thanks,
-- Shuah
