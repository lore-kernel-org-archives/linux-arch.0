Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f65.google.com ([74.125.82.65]:33526 "EHLO
	mail-wg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbBTSCw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Feb 2015 13:02:52 -0500
From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: [PATCH v2 16/18] ARM: dts: Introduce STM32F429 MCU
Date: Fri, 20 Feb 2015 19:01:15 +0100
Message-Id: <1424455277-29983-17-git-send-email-mcoquelin.stm32@gmail.com>
In-Reply-To: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: u.kleine-koenig@pengutronix.de, afaerber@suse.de, geert@linux-m68k.org, Rob Herring <robh+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Joe Perches <joe@perches.com>, Antti Palosaari <crope@iki.fi>, Tejun Heo <tj@kernel.org>, Will Deacon <will.deacon@arm.com>, Nikolay Borisov <Nikolay.Borisov@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Kees Cook <keescook@chromium.org>, Michal Marek <mmarek@suse.cz>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

The STMicrolectornics's STM32F419 MCU has the following main features:
 - Cortex-M4 core running up to @180MHz
 - 2MB internal flash, 256KBytes internal RAM
 - FMC controller to connect SDRAM, NOR and NAND memories
 - SD/MMC/SDIO support
 - Ethernet controller
 - USB OTFG FS & HS controllers
 - I2C, SPI, CAN busses support
 - Several 16 & 32 bits general purpose timers
 - Serial Audio interface
 - LCD controller

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/boot/dts/Makefile            |   1 +
 arch/arm/boot/dts/stm32f429-disco.dts |  41 ++++
 arch/arm/boot/dts/stm32f429.dtsi      | 396 ++++++++++++++++++++++++++++++++++
 3 files changed, 438 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32f429-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32f429.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..d7da0ef 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -442,6 +442,7 @@ dtb-$(CONFIG_ARCH_STI)+= stih407-b2120.dtb \
 	stih416-b2000.dtb \
 	stih416-b2020.dtb \
 	stih416-b2020e.dtb
+dtb-$(CONFIG_ARCH_STM32)+= stm32f429-disco.dtb
 dtb-$(CONFIG_MACH_SUN4I) += \
 	sun4i-a10-a1000.dtb \
 	sun4i-a10-ba10-tvbox.dtb \
diff --git a/arch/arm/boot/dts/stm32f429-disco.dts b/arch/arm/boot/dts/stm32f429-disco.dts
new file mode 100644
index 0000000..0e79cc1
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f429-disco.dts
@@ -0,0 +1,41 @@
+/dts-v1/;
+#include "stm32f429.dtsi"
+
+/ {
+	model = "STMicroelectronics's STM32F429i-DISCO board";
+	compatible = "st,stm32f429i-disco", "st,stm32f429";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 root=/dev/ram rdinit=/linuxrc";
+		linux,stdout-path = &usart1;
+	};
+
+	memory {
+		reg = <0xd0000000 0x800000>;
+	};
+
+	aliases {
+		ttyS0 = &usart1;
+	};
+
+	soc {
+		usart1: usart@40011000 {
+			status = "okay";
+		};
+
+		leds {
+			compatible = "gpio-leds";
+			red {
+				#gpio-cells = <2>;
+				label = "Front Panel LED";
+				gpios = <&gpiog 14 0>;
+				linux,default-trigger = "heartbeat";
+			};
+			green {
+				#gpio-cells = <2>;
+				gpios = <&gpiog 13 0>;
+				default-state = "off";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
new file mode 100644
index 0000000..5b3442a
--- /dev/null
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -0,0 +1,396 @@
+/*
+ * Device tree for STM32F429
+ */
+#include "armv7-m.dtsi"
+#include <dt-bindings/pinctrl/pinctrl-stm32.h>
+#include <dt-bindings/reset/st,stm32f429.h>
+
+/ {
+
+	aliases {
+		gpio0 = &gpioa;
+		gpio1 = &gpiob;
+		gpio2 = &gpioc;
+		gpio3 = &gpiod;
+		gpio4 = &gpioe;
+		gpio5 = &gpiof;
+		gpio6 = &gpiog;
+		gpio7 = &gpioh;
+		gpio8 = &gpioi;
+		gpio9 = &gpioj;
+		gpio10 = &gpiok;
+	};
+
+	clocks {
+		clk_sysclk: clk-sysclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <180000000>;
+		};
+
+		clk_hclk: clk-hclk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <180000000>;
+		};
+
+		clk_pclk1: clk-pclk1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <45000000>;
+		};
+
+		clk_pclk2: clk-pclk2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <90000000>;
+		};
+
+		clk_pmtr1: clk-pmtr1 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <90000000>;
+		};
+
+		clk_pmtr2: clk-pmtr2 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <180000000>;
+		};
+
+		clk_systick: clk-systick {
+			compatible = "fixed-factor-clock";
+			clocks = <&clk_hclk>;
+			#clock-cells = <0>;
+			clock-div = <8>;
+			clock-mult = <1>;
+		};
+	};
+
+	systick: timer@e000e010 {
+		clocks = <&clk_systick>;
+
+		status = "okay";
+	};
+
+	soc {
+		reset: reset@40023810 {
+			#reset-cells = <1>;
+			compatible = "st,stm32-reset";
+			reg = <0x40023810 0x18>;
+		};
+
+		pin-controller {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "st,stm32-pinctrl";
+			ranges = <0 0x40020000 0x3000>;
+
+			gpioa: gpio@40020000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x0 0x400>;
+				resets = <&reset GPIOA_RESET>;
+				st,bank-name = "GPIOA";
+			};
+
+			gpiob: gpio@40020400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x400 0x400>;
+				resets = <&reset GPIOB_RESET>;
+				st,bank-name = "GPIOB";
+			};
+
+			gpioc: gpio@40020800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x800 0x400>;
+				resets = <&reset GPIOC_RESET>;
+				st,bank-name = "GPIOC";
+			};
+
+			gpiod: gpio@40020c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0xc00 0x400>;
+				resets = <&reset GPIOD_RESET>;
+				st,bank-name = "GPIOD";
+			};
+
+			gpioe: gpio@40021000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1000 0x400>;
+				resets = <&reset GPIOE_RESET>;
+				st,bank-name = "GPIOE";
+			};
+
+			gpiof: gpio@40021400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1400 0x400>;
+				resets = <&reset GPIOF_RESET>;
+				st,bank-name = "GPIOF";
+			};
+
+			gpiog: gpio@40021800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1800 0x400>;
+				resets = <&reset GPIOG_RESET>;
+				st,bank-name = "GPIOG";
+			};
+
+			gpioh: gpio@40021c00 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x1c00 0x400>;
+				resets = <&reset GPIOH_RESET>;
+				st,bank-name = "GPIOH";
+			};
+
+			gpioi: gpio@40022000 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2000 0x400>;
+				resets = <&reset GPIOI_RESET>;
+				st,bank-name = "GPIOI";
+			};
+
+			gpioj: gpio@40022400 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2400 0x400>;
+				resets = <&reset GPIOJ_RESET>;
+				st,bank-name = "GPIOJ";
+			};
+
+			gpiok: gpio@40022800 {
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x2800 0x400>;
+				resets = <&reset GPIOK_RESET>;
+				st,bank-name = "GPIOK";
+			};
+
+			usart1 {
+				pinctrl_usart1: usart1-0 {
+					st,pins {
+						tx = <&gpioa 9 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioa 10 ALT7 NO_PULL>;
+					};
+				};
+			};
+
+			usart2 {
+				pinctrl_usart2: usart2-0 {
+					st,pins {
+						tx = <&gpioa 2 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioa 3 ALT7 NO_PULL>;
+					};
+				};
+			};
+
+			usart3 {
+				pinctrl_usart3: usart3-0 {
+					st,pins {
+						tx = <&gpiob 10 ALT7 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpiob 11 ALT7 NO_PULL>;
+					};
+				};
+			};
+
+			usart4 {
+				pinctrl_usart4: usart4-0 {
+					st,pins {
+						tx = <&gpioa 0 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioa 1 ALT8 NO_PULL>;
+					};
+				};
+			};
+
+			usart5 {
+				pinctrl_usart5: usart5-0 {
+					st,pins {
+						tx = <&gpioc 12 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpiod 2 ALT8 NO_PULL>;
+					};
+				};
+			};
+
+			usart6 {
+				pinctrl_usart6: usart6-0 {
+					st,pins {
+						tx = <&gpioc 6 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioc 7 ALT8 NO_PULL>;
+					};
+				};
+			};
+
+			usart7 {
+				pinctrl_usart7: usart7-0 {
+					st,pins {
+						tx = <&gpioe 8 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioe 7 ALT8 NO_PULL>;
+					};
+				};
+			};
+
+			usart8 {
+				pinctrl_usart8: usart8-0 {
+					st,pins {
+						tx = <&gpioe 1 ALT8 NO_PULL PUSH_PULL LOW_SPEED>;
+						rx = <&gpioe 0 ALT8 NO_PULL>;
+					};
+				};
+			};
+		};
+
+		timer2: timer@40000000 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000000 0x400>;
+			interrupts = <28>;
+			resets = <&reset TIM2_RESET>;
+			clocks = <&clk_pmtr1>;
+
+			status = "disabled";
+		};
+
+		timer3: timer@40000400 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000400 0x400>;
+			interrupts = <29>;
+			resets = <&reset TIM3_RESET>;
+			clocks = <&clk_pmtr1>;
+
+			status = "disabled";
+		};
+
+		timer4: timer@40000800 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000800 0x400>;
+			interrupts = <30>;
+			resets = <&reset TIM4_RESET>;
+			clocks = <&clk_pmtr1>;
+
+			status = "disabled";
+		};
+
+		timer5: timer@40000c00 {
+			compatible = "st,stm32-timer";
+			reg = <0x40000c00 0x400>;
+			interrupts = <50>;
+			resets = <&reset TIM5_RESET>;
+			clocks = <&clk_pmtr1>;
+		};
+
+		timer6: timer@40001000 {
+			compatible = "st,stm32-timer";
+			reg = <0x40001000 0x400>;
+			interrupts = <54>;
+			resets = <&reset TIM6_RESET>;
+			clocks = <&clk_pmtr1>;
+
+			status = "disabled";
+		};
+
+		timer7: timer@40001400 {
+			compatible = "st,stm32-timer";
+			reg = <0x40001400 0x400>;
+			interrupts = <55>;
+			resets = <&reset TIM7_RESET>;
+			clocks = <&clk_pmtr1>;
+
+			status = "disabled";
+		};
+
+		usart1: usart@40011000 {
+			compatible = "st,stm32-usart";
+			reg = <0x40011000 0x400>;
+			interrupts = <37>;
+			clocks = <&clk_pclk2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart2: usart@40004400 {
+			compatible = "st,stm32-usart";
+			reg = <0x40004400 0x400>;
+			interrupts = <38>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart3: usart@40004800 {
+			compatible = "st,stm32-usart";
+			reg = <0x40004800 0x400>;
+			interrupts = <39>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart4: usart@40004c00 {
+			compatible = "st,stm32-usart";
+			reg = <0x40004c00 0x400>;
+			interrupts = <52>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart5: usart@40005000 {
+			compatible = "st,stm32-usart";
+			reg = <0x40005000 0x400>;
+			interrupts = <53>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart6: usart@40011400 {
+			compatible = "st,stm32-usart";
+			reg = <0x40011400 0x400>;
+			interrupts = <71>;
+			clocks = <&clk_pclk2>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart7: usart@40007800 {
+			compatible = "st,stm32-usart";
+			reg = <0x40007800 0x400>;
+			interrupts = <82>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+
+		usart8: usart@40007c00 {
+			compatible = "st,stm32-usart";
+			reg = <0x40007c00 0x400>;
+			interrupts = <83>;
+			clocks = <&clk_pclk1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usart1>;
+
+			status = "disabled";
+		};
+	};
+};
-- 
1.9.1

