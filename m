From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v12 22/22] selftests/vm: Fix deadlock in
 protection_keys.c
Date: Mon, 26 Feb 2018 10:19:51 +1100
Message-ID: <20180226101951.0136f963@balbir.ozlabs.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
        <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ram Pai <linuxram@us.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Feb 2018 17:55:41 -0800
Ram Pai <linuxram@us.ibm.com> wrote:

> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> The sig_chld() handler calls dprintf2() taking care of setting
> dprint_in_signal so that sigsafe_printf() won't call printf().
> Unfortunately, this precaution is is negated by dprintf_level(), which
> has a call to fflush().
>

fflush() is not the signal-safe function list, so this makes sense.
I wonder if fflush() is needed in sigsafe_printf()?

How about?

diff --git a/tools/testing/selftests/x86/pkey-helpers.h b/tools/testing/selftests/x86/pkey-helpers.h
index b3cb7670e026..2c3b39851f10 100644
--- a/tools/testing/selftests/x86/pkey-helpers.h
+++ b/tools/testing/selftests/x86/pkey-helpers.h
@@ -29,6 +29,7 @@ static inline void sigsafe_printf(const char *format, ...)
 	va_start(ap, format);
 	if (!dprint_in_signal) {
 		vprintf(format, ap);
+		fflush(NULL);				\
 	} else {
 		int ret;
 		int len = vsnprintf(dprint_in_signal_buffer,
@@ -49,7 +50,6 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)


But both are equivalent I guess, so
Acked-by: Balbir Singh <bsingharora@gmail.com>
